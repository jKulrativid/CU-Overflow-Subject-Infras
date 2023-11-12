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

## First, pull submodules
```bash
make init_submodules
```

## Create Local Repository
```bash
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

## Set envs
```bash
export PUBLIC_IP=<YOUR IP.v4 Address>
```

## Setup Web's Vite Gateway URI before building image
Go to ./SA-Front-End and change value of .env to Nginx Ingress Controller's URL

## Setup Gateway config before building image
Since we accentially hardcode gateway's dependency uri in JS file
If you need to change service name, please look API-Gateway-SA/src/common/constants

## Build All Images
```bash
make build_images
```
#### Note:
If you want to change web service (frontend) configuration, see '.env' file in SA-Front-End directory.

## Create Secret Configmap
#### It is surely a bad practice but it will be patched soon ^^.
Set secret as described in the .yaml.template in each Helm Chart's template

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

## Finally, you can reach the frontend at localhost (port 80)

## To uninstall services, run
```bash
make uninstall_charts
make uninstall_common
```

# Updating

## First, update each submodules
```bash
make update_submodules
```

## Then rebuild all images
```bash
make build_images
```

## Lastly
```bash
make uninstall_charts
make install_charts
```
