# How to Install Traefik

## TL;DR
```bash
$ helm install traefik traefik/traefik -f values.yaml
```
Done

## Stack

The project consist of 1 deployment with 3 replicas. It's deployed in the default namespace

### ConfigMap
If you edit the values you need to upgrade the deployment using this command:

``` bash
helm  upgrade --install traefik traefik/traefik -f values.yaml
```

## Useful link

- https://doc.traefik.io/traefik/

- https://github.com/traefik/traefik-helm-chart/tree/master/traefik