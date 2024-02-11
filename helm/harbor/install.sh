helm repo add harbor https://helm.goharbor.io
kubectl create ns hb
helm install harbor harbor/harbor -n hb