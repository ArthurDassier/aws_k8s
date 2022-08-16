# How to Install GitLab Runner on Kubernetes

## TL;DR
```bash
kubectl create namespace gitlab-runner
kubectl apply -R -f .
```

## Register the Runner on GitLab

The first step to deploying a Gitlab Runner on Kubernetes is to obtain a registration token from Gitlab. This token is necessary because it create a new authentication token that connects the Runner to Gitlab.

The easiest way to register a Runner is to start a Docker container locally with the Runner:

```
docker run -it --entrypoint /bin/bash gitlab/gitlab-runner:latest
```
Next, we can register the Runner with this command inside the container:

```
gitlab-runner register
```

Here is where we take the registration information we got from the Gitlab repository and use it to register a new Runner. Using the provided information, complete the form as follows. Replace [REGISTRATION TOKEN] with your registration token.

```
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
https://gitlab.com/

Please enter the gitlab-ci token for this runner:
[REGISTRATION TOKEN]

Please enter the gitlab-ci description for this runner:
[RUNNER-ID]: My first Gitlab runner!

Please enter the gitlab-ci tags for this runner (comma separated):
tutorial

Whether to lock the Runner to current project [true/false]:
[true]: false

Registering runner... succeeded                     runner=[RUNNER ID]

Please enter the executor: shell, ssh, docker+machine, docker-ssh+machine, kubernetes, docker, docker-ssh, parallels, virtualbox:
docker

Please enter the default Docker image (e.g. ruby:2.1):
busybox:latest

Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```

To check if the registration was successful, return to your browser, and refresh the page. Under the registration information will be the new Runner. This Runner should be disconnected with an error.

he final step is to extract the authentication token from the local Runner. When we registered the Runner, Gitlab saved an authentication token in the docker container. Before launching the runner to Kubernetes, we need to get this authentication token.

This token is necessary because it connects your Runner to Gitlab and designates a stable ID for your Runner. When Pods are restarted automatically by Kubernetes, a stable ID allows Gitlab to reference the same logical Runner after each restart.

To find the authentication token, we need to open the generated configuration file from the registration process. In the terminal, run this command to view the configuration.

```
$ vim /etc/gitlab-runner/config.toml

concurrent = 1
check_interval = 0

[[runners]]
  name = "temp runner"
  url = "https://gitlab.com/"
  token = [TOKEN]
  executor = "docker"
  [runners.docker]
    tls_verify = false
    image = "busybox:latest"
    privileged = false
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
  [runners.cache]
```

Above is the configuration that Gitlab created when we registered the runner. I redacted my token for security purposes and renamed it to [TOKEN]. Copy this token and make sure not to lose it, as it is the only way to authenticate the newly registered Runner to Gitlab. Once properly stored, it is safe to shutdown and remove the Docker instance.

Replace the token inside `gitlab-runner-confi.yaml` then, run these commands:
```
kubectl create namespace gitlab-runner
kubectl apply -R -f .
```
The Runner should be deployed to Kubernetes and it should accept jobs now.

Check if it's working properly:

```
kubectl get pods --namespace gitlab-runner
```

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
