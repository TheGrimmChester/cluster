create a local file called thanos.yaml
type: S3
config:
    endpoint: "minioingress.rook-minio.10.85.166.33.xip.io"
    bucket: "thanos"
    access_key: "MINIO_Access_Key"
    secret_key: "MINIO_Secret_Key"
    insecure: true
    signature_version2: false
then use $ kubectl create secret generic thanos-objstore-config --from-file=thanos.yaml=thanos-config.yaml -n <namespace> to create the base64 encrypted secret.

then use $ kubectl edit secret thanos-objstore-config -n <namespace> -o yaml to see the encrypted yaml file

# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
data:
  thanos.yaml: dHlwZTogczMKY29uZmlnOgoggrr2J1Y2tldDogbXNtLWdiLXByb21ldGhldXMxLWJsdWUKICBlbmNyeXB0c3NlOiB0cnVlCg==
kind: Secret
metadata:
  creationTimestamp: "2019-05-17T17:12:41Z"
  name: thanos-objstore-config
  namespace: default
  resourceVersion: "928656"
  selfLink: /api/v1/namespaces/default/secrets/thanos-objstore-config
  uid: fabe95c2-78c6-1fr49-9030-02f4ee719eec
type: Opaque
then create a basic helm chart using helm init with a single deployment template that uses the encrypted yaml file
apiVersion: v1
kind: Secret
metadata:
  name: thanos-objstore-config
type: Opaque
data:
   thanos.yaml: dHlwZTogczMKY29uZmlnOgoggrr2J1Y2tldDogbXNtLWdiLXByb21ldGhldXMxLWJsdWUKICBlbmNyeXB0c3NlOiB0cnVlCg==
when you run helm install it'll create the secret for you.
