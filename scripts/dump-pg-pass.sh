kubectl get secret --namespace database postgres-v15 -o jsonpath="{.data.password}" | base64 --decode
