# get pods, deployments, statefulsets, pvs, pvcs, services, secrets
kubectl get pods 

kubectl describe pod mongo-pod-1

kubectl delete pvcs --all 

# Note: You must use create in order to allocate nodeAffinity.

kubectl create -f pvc.yaml

kubectl apply -k .

kubectl apply -f ./config.yaml

kubectl exec -it mongo-pod -- sh

mongo --host <ip> --port <port> -u adminuser -p password123

db.users.insert({comment: "ok"})

#find the local db directory

find / -type d -name "disk1"

# get cluster ips of pods

kubectl get pod -o wide

# get endpoints of svc

kubectl describe endpoint