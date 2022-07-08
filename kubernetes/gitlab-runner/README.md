# How to Install GitLab Runner on Kubernetes

## TL;DR
```bash
$ kubectl create namespace gitlab-runner
$ kubectl apply -f *.yaml
```
Done

## Stack

The project consist of 1 deployment with 3 replicas and a volume mounted on:

    /etc/gitlab-runner/config.toml

The stack is deployed in the gitlab-runner namespace

### ConfigMap
There can be a maximum of 3 concurrent job at the same time. If you edit the ConfigMap you need to delete the deployment and restart it using this command:

``` bash
kubectl rollout restart -f gitlab-runner-deployment.yaml
```

### Service Account
    name: gitlab-admin
    namespace: gitlab-runner
    rules:
        apiGroups: [""]
        resources: ["*"]
        verbs: ["*"]

## Useful link

- https://adambcomer.com/blog/install-gitlab-runner-kubernetes/


# Commande a tester

    kubectl auth can-i create pods --as dev-user --namespace test