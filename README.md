# CU-Overflow-Subject-Infras

# Installation

## Required
- Kubernetes
- Helm
- Make

## Install Nginx as Ingress Controller
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install nginx-ingress ingress-nginx/ingress-nginx
```
