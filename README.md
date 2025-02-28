#### Follow [@K8SUG](https://linktr.ee/k8sug) on Linktree - your one-stop hub for all social platforms

I just want to build an AKS Cluster to play with the various Security and Data Management capabilities e.g. Security Scans, Backup/Restore, Disaster Recovery and Application Mobility. It is challenging to create AKS Cluster from Azure Cloud if you are not familiar to it. After the AKS Cluster is up running, we still need to install a sample database, create policies etc.. The whole process is not that simple.

#### Follow [@K8SUG](https://linktr.ee/k8sug) on Linktree - your one-stop hub for all social platforms

This script based automation allows you to build a ready-to-use AKS demo environment with PostgreSQL deployed in ~5 minutes. And you can enable AKS Container backups via Velero in ~1 minute. For simplicity and cost optimization, the AKS cluster will have only one worker node in the newly created vnet and subnet. This is bash shell based scripts which has been tested on Cloud Shell. Linux or MacOS terminal has not been tested though it might work as well. If you don't have an Azure account, please watch the video by Louisa below to sign up a free trial account in 5 minutes. 

# Sign up an Azure trial account
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/FN0ARvEdrjg/0.jpg)](https://www.youtube.com/watch?v=FN0ARvEdrjg)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Here're the prerequisities. 
1. Go to open Azure Cloud Shell
2. Clone the github repo, run below command
````
git clone https://github.com/yongkanghe/aks-casa.git;cd aks-casa
````
3. Optionally, you can customize the clustername, vm size, location, region, containername, etc.
````
vi setenv.sh
````

# AKS Cluster Automation 

1. To deploy an AKS cluster
````
./aks-deploy.sh
````

2. To destroy the AKS cluster after testing
````
./aks-destroy.sh
````

# AKS 1.29 Automation video
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/CNkw4PjgsJk/0.jpg)](https://www.youtube.com/watch?v=CNkw4PjgsJk)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Velero for AKS Automation 

1. 1 min to enable AKS Backup via Velero
````
./velero-deploy.sh
````

2. To clean up Velero for GKE
````
./velero-destroy.sh
````

# Build an AKS creation via Portal
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/hNU72Ump92E/0.jpg)](https://www.youtube.com/watch?v=hNU72Ump92E)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Build, Protect and Migrate Containers
[![IMAGE ALT TEXT HERE](https://pbs.twimg.com/media/FK5rsaeXwAIEmtI?format=jpg&name=small)](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# CloudCasa - Best Kubernetes Backup as a Service
https://cloudcasa.io 

# Contributors

#### Follow 🔥 [@K8SUG](https://linktr.ee/k8sug) on Linktree - your one-stop hub for all social platforms
