# How to Install Traefik

## TL;DR
```bash
helm repo add traefik https://helm.traefik.io/traefik

helm repo update

helm install traefik traefik/traefik -f traefik-values.yaml
```
Done

## Stack

The project consist of 1 deployment with 3 replicas. It's deployed in the default namespace.

We configured Traefik to automatically redirect all HTTP traffic on port 80 to HTTPS port 443.

Port 27017 is opened to TCP traffic to allow external users to connect to mongoDB services.

### ConfigMap
If you edit the values you need to upgrade the deployment using this command:

``` bash
helm repo update traefik

helm upgrade --install traefik traefik/traefik -f traefik-values.yaml
```

## Useful link

- https://doc.traefik.io/traefik/

- https://github.com/traefik/traefik-helm-chart/tree/master/traefik