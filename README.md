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

## Create Secret Configmap
#### It is surely a bad practice but it will be patched soon ^^.
Place config-map (secret) in ./helm/common/template

## SSL Certificates Installation
```bash
make gen_cert
make read_cert
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
kubectl port-forward service/nginx-ingress-ingress-nginx-controller 8000:80 --address 0.0.0.0
```

## You can reach the frontend at localhost (port 80)

## To uninstall services, run
```bash
make uninstall_charts
make uninstall_common
```
