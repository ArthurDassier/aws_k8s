# Prometheus

This stack is meant for cluster monitoring, so it is pre-configured to collect metrics from all Kubernetes components.

Official documentation:
- https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack

## Monitoring

It is very important that you remember that every monitoring related pods are created in the monitoring namespace

## Installation

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

helm upgrade --install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring -f prometheus-values.yaml
```

`helm repo update` followed by `helm upgrade` command can also be used individually when you make change to the helm values YAML.

## CPU Throttling alert

- https://github.com/robusta-dev/alert-explanations/wiki/CPUThrottlingHigh-(Prometheus-Alert)