# Kubernetes environment

## Ingress

### Traefik

Traefik is an open-source reverse proxy. It allows us to expose our services to the internet easily.

- https://doc.traefik.io/traefik/

### Helm

Helm is a package manager for Kubernetes, it allows us to deploy Traefik without worrying about the configuration. We can specify some details with the values.yaml file inside the ingress folder.

- https://helm.sh/docs/

## GitLab Runner

GitLab Runner can use Kubernetes to run builds on a Kubernetes cluster. This is possible with the use of the Kubernetes executor.

- https://docs.gitlab.com/runner/executors/kubernetes.html

