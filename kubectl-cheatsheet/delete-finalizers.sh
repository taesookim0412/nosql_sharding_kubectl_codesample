kubectl patch pv pv-data-1 -p '{"metadata":{"finalizers":null}}'
kubectl patch pvc pv-data-1-pvc -p '{"metadata":{"finalizers":null}}'


kubectl patch pv test-local-pv -p '{"metadata":{"finalizers":null}}'
kubectl patch pvc test-pvc -p '{"metadata":{"finalizers":null}}'

# delete pvc then pv to avoid this issue