echo '-------Destroy a MySQL database'
helm uninstall mysql -n yong-mysql
kubectl delete namespace yong-mysql