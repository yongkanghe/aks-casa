echo '-------Remove Velero for AKS and Clean up (typically in 3 mins)'
starttime=$(date +%s)
. ./setenv.sh

velero uninstall --force

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to clean up the env is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'