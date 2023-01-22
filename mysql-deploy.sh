echo '-------Deploy a MySQL database'
kubectl create namespace yong-mysql
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install mysql bitnami/mysql --namespace=yong-mysql \
  --set primary.persistence.size=1Gi,secondary.persistence.size=1Gi
