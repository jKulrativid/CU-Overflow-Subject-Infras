# CU-Overflow-Subject-Infras

# Installation

## Required
- Docker
- Kubernetes
- Helm
- Make
- Around 10Gib Disk Space for Persistent Volume in Master Node
- MongoDB Atlas for API Gateway Auth Service

## Build All Images
```bash
make build_images
```
#### Note:
If you want to change web service (frontend) configuration, see '.env' file in SA-Front-End directory.

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

### You can reach the frontend at localhost (port 80)

## To uninstall services, run
```bash
make uninstall_charts
```