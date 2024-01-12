kubectl scale statefulset,deployment -n monitoring --all --replicas=1
kubectl scale statefulset,deployment -n default --all --replicas=1
#kubectl scale statefulset,deployment -n networking --all --replicas=1
kubectl scale statefulset,deployment -n home-automation --all --replicas=1
#kubectl scale statefulset,deployment -n database --all --replicas=1
kubectl scale statefulset,deployment -n media --all --replicas=1
kubectl scale statefulset,deployment -n other --all --replicas=1
kubectl scale statefulset,deployment -n security --all --replicas=1
