echo '-------Remove Velero for AKS and Clean up (typically in ~1 min)'
starttime=$(date +%s)
. ./setenv.sh

velero uninstall --force
AKS_RG=$(az group list -o table | grep $MY_PREFIX-$MY_GROUP | grep MC | awk '{print $1}')
az storage account delete -n $MY_PREFIX$AZURE_STORAGE_ACCOUNT_ID -g $AKS_RG -y

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to clean up the env is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'