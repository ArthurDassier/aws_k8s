# How to Install Cert-Manager

## TL;DR

    https://cert-manager.io/docs/installation/helm/#prerequisites

```
helm  upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.8.2 -f cert-manager.values.yaml
```

There is two YAML files that you need to apply individually:

```
kubectl apply -f cert-manager.clusterissuer.yaml
kubectl apply -f cert-manager.aws-secret.yaml
```

## Let’s Encrypt rate limits

Let’s Encrypt have rate limits, for testing purpose you should use let's encrypt staging server (ACME server to use in ClusterIssuer yaml). These certificates won't be trusted by most external parties.

- https://letsencrypt.org/docs/rate-limits/

## Official documentation

- https://cert-manager.io/docs/

## Official GitHub repository

- https://github.com/cert-manager/cert-manager

## Useful link

- https://www.youtube.com/watch?v=hoLUigg4V18