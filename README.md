# CU-Overflow-Subject-Infras

# Installation

## Required
- Ubuntu Instance with >2 vCPU Cores and > 2GiB of RAM
- Docker
- Kubernetes
- Helm
- Make
- Around 10Gib Disk Space for Persistent Volume in Master Node
- MongoDB URI Atlas for API Gateway Auth Service

## Set Env Variables
```bash
export PUBLIC_IP=
export CERT_KEY_PASSWORD=
```

## Deploy Cert Manager
```bash
helm upgrade --install --wait --timeout 15m \
  --namespace cert-manager --create-namespace \
  --repo https://charts.jetstack.io cert-manager cert-manager \
  --values - <<EOF
installCRDs: true
EOF
```

## Create Secret Configmap
#### It is surely a bad practice but it will be patched soon ^^.
Place config-map (secret) in ./helm/common/template

## SSL Certificates Installation
```bash
make gen_cert
make read_cert
```

## Create Cluster Issue
```bash
kubectl apply -n cert-manager -f - <<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ca-issuer
spec:
  ca:
    secretName: ingress-cert
EOF
```

## Install Common
```bash
make install_common
```

## Install Nginx as Ingress Controller
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install nginx-ingress ingress-nginx/ingress-nginx
```

## Place certificate file
### Place your certificate.crt and private.key to directory ./certs
### Then run
```bash
make read_cert_secret
```

## Install Services with Helm
```bash
make install_charts
```

## After the filestorage db finished installation, run Prisma migrator
```bash
make migrate_db
```

and after migration is finished (the website is properly running), run
```bash
make finish_migrate_db
```

## Finally, run
```bash
kubectl port-forward service/nginx-ingress-ingress-nginx-controller 8000:443 --address 0.0.0.0
```

## You can reach the frontend at localhost (port 8000)

## To uninstall services, run
```bash
make uninstall_charts
make uninstall_common
```
