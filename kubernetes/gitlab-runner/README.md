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

```plantuml
storage gitlab-runner {
node gitlabRunner #darkorange
rectangle serviceAccount #darkorange
artifact secrets #darkorange
database volume #dodgerblue;text:white
collections jobs #dodgerblue;text:white;line:black
artifact configMap #darkorange
rectangle clusterRole #darkorange
rectangle storageClass #darkorange
}
rectangle existing #darkorange
rectangle createdAtRuntime #dodgerblue;text:white
cloud GitLab #orangered
collections deployments #dodgerblue;text:white;line:black
gitlabRunner -[#black]-> serviceAccount : use
gitlabRunner -[#black]-> secrets : retrieve
gitlabRunner -[#black,dashed]-> volume : create
gitlabRunner -[#black,dashed]-> jobs : create
serviceAccount -[#black]-> GitLab : read
volume -[#black]-> configMap : retrieve
jobs -[#black]-> clusterRole : use
clusterRole -[#black,dashed]-> deployments : create update patch list get delete
deployments -[#black]-> storageClass : use
```

The stack is deployed in the gitlab-runner namespace, inside our private subnet as to forbid ingress access. We use a secret for our deployment to provide GitLab credentials.

### ConfigMap
There can be a maximum of 2 concurrent job at the same time. If you edit the ConfigMap you need to delete the deployment and restart it using this command:

``` bash
kubectl rollout restart -f gitlab-runner-deployment.yaml
```

### Storage Class

Having our custom storage class serve only one purpose: to be able to delete Persistent Volumes automatically at PVClaims deletion.

### Service Account
    name: gitlab-admin
    namespace: gitlab-runner
    rules:
        apiGroups: [""]
        resources: ["*"]
        verbs: ["*"]

## Useful link

- https://adambcomer.com/blog/install-gitlab-runner-kubernetes/
