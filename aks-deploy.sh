echo '-------Creating an AKS Cluster only (~5 mins)'
starttime=$(date +%s)
. ./setenv.sh
az group create --name $MY_PREFIX-$MY_GROUP --location $MY_LOCATION
AKS_K8S_VERSION=$(az aks get-versions --location $MY_LOCATION --output table | awk '{print $1}' | grep $K8S_VERSION | head -1)
az aks create \
  --resource-group $MY_PREFIX-$MY_GROUP \
  --name $MY_PREFIX-$MY_CLUSTER-$(date +%s) \
  --location $MY_LOCATION \
  --generate-ssh-keys \
  --kubernetes-version $AKS_K8S_VERSION \
  --node-count 3 \
  --node-vm-size $MY_VMSIZE \
  --enable-cluster-autoscaler \
  --min-count 3 \
  --max-count 5 \
  --network-plugin azure

az aks get-credentials -g $MY_PREFIX-$MY_GROUP -n $(az aks list -g $MY_PREFIX-$MY_GROUP -o table | grep $MY_PREFIX-$MY_CLUSTER | awk '{print $1}')

echo "" | awk '{print $1}'
./postgresql-deploy.sh

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time to build an AKS Cluster with PostgreSQL is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'
