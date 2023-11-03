# CU-Overflow-Subject-Infras

# Installation

## Required
- Docker
- Kubernetes
- Helm
- Make
- Around 10Gib Disk Space for Persistent Volume in Master Node

## Build All Images
```bash
make build_images
```

## Create Secret Configmap
#### It is surely a bad practice but it will be patched soon ^^.
Set secret as described in the .yaml.template in each Helm Chart's template

## Install Nginx as Ingress Controller
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install nginx-ingress ingress-nginx/ingress-nginx
```

## Install Services with Helm
```bash
make install_charts
```

## To uninstall services, run
```bash
make uninstall_charts
```