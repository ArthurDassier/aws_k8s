    helm upgrade --install monitoring  prometheus-community/kube-prometheus-stack --namespace monitoring -f prometheus-values.yaml

- https://github.com/robusta-dev/alert-explanations/wiki/CPUThrottlingHigh-(Prometheus-Alert)