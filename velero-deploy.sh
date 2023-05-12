echo '-------Deploy Velero for GKE Backup (typically in ~1 min)'
starttime=$(date +%s)
. ./setenv.sh

echo "-------Download and Install verlero"
if [ ! -f ~/aks-casa/velero ]; then
  wget https://github.com/vmware-tanzu/velero/releases/download/v1.10.3/velero-v1.10.3-linux-amd64.tar.gz
  tar -zxvf velero-v1.10.3-linux-amd64.tar.gz
  mv velero-v1.10.3-linux-amd64/velero ~/aks-casa
  rm velero-v1.10.3-linux-amd64.tar.gz
  rm -rf velero-v1.10.3-linux-amd64.tar.gz
fi

echo '-------Create a Azure storage account & blob container'
AKS_RG=$(az group list -o table | grep $MY_PREFIX-$MY_GROUP | grep MC | awk '{print $1}')
az storage account create -n $MY_PREFIX$AZURE_STORAGE_ACCOUNT_ID -g $AKS_RG -l $MY_LOCATION --sku Standard_LRS
echo $(az storage account keys list -g $AKS_RG -n $MY_PREFIX$AZURE_STORAGE_ACCOUNT_ID --query [].value -o tsv | head -1) > az_storage_key
az storage container create -n $MY_PREFIX-$MY_CONTAINER --account-key $(cat az_storage_key) --account-name $MY_PREFIX$AZURE_STORAGE_ACCOUNT_ID

echo '-------Create a service principal for Velero'
AZURE_SUBSCRIPTION_ID=`az account list --query '[?isDefault].id' -o tsv`
AZURE_TENANT_ID=`az account list --query '[?isDefault].tenantId' -o tsv`
AZURE_CLIENT_SECRET=`az ad sp create-for-rbac --name "velero" --role "Contributor" --scopes /subscriptions/$AZURE_SUBSCRIPTION_ID --query 'password' -o tsv`
AZURE_CLIENT_ID=`az ad sp list --display-name "velero" --query '[0].appId' -o tsv`

cat << EOF  > ./credentials-velero
AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
AZURE_TENANT_ID=${AZURE_TENANT_ID}
AZURE_CLIENT_ID=${AZURE_CLIENT_ID}
AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
AZURE_RESOURCE_GROUP=${AKS_RG}
EOF

echo "-------Install & Start velero on AKS"
velero install \
    --provider azure \
    --plugins velero/velero-plugin-for-microsoft-azure:v1.0.0 \
    --bucket $MY_PREFIX-$MY_CONTAINER \
    --secret-file ./credentials-velero \
    --backup-location-config resourceGroup=$AKS_RG,storageAccount=$MY_PREFIX$AZURE_STORAGE_ACCOUNT_ID

echo "-------One time On-Demand Backup of yong-postgresql namespace"
kubectl wait --for=condition=ready --timeout=180s -n velero pod -l component=velero

kubectl get bsl -n velero | grep Unavailable
if [ `echo $?` -eq 0 ]
then
  echo '-------Waiting for BSL becomes available'
  sleep 15
fi

kubectl get bsl -n velero | grep Unavailable
if [ `echo $?` -eq 0 ]
then
  echo '-------Waiting for BSL becomes available'
  sleep 10
fi

kubectl get bsl -n velero | grep Unavailable
if [ `echo $?` -eq 0 ]
then
  echo '-------Waiting for BSL becomes available'
  sleep 5
fi

velero backup create yong-postgresql-backup --include-namespaces yong-postgresql

echo "-------Hourly scheduled backup of yong-postgresql namespace"
kubectl create -f velero-schedule.yaml

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to enable Velero backup for GKE is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'