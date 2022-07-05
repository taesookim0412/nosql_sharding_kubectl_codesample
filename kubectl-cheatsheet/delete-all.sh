kubectl delete deployments --all
kubectl delete statefulsets --all
kubectl delete pods --all --grace-period=0 --force
kubectl delete pvc --all
kubectl delete pv --all
kubectl delete services --all
kubectl delete secrets --all
kubectl delete storageclass --all
