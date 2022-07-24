# Kubernetes environment

## Traefik

Traefik is an open-source reverse proxy. It allows us to expose our services to the internet easily via Ingress Routing.

- https://doc.traefik.io/traefik/

## Helm

Helm is a package manager for Kubernetes, it allows us to deploy Traefik without worrying about the configuration. We can specify some details with the values.yaml file inside the ingress folder.

- https://helm.sh/docs/

## GitLab Runner

GitLab Runner can use Kubernetes to run builds on a Kubernetes cluster. This is possible with the use of the Kubernetes executor.

- https://docs.gitlab.com/runner/executors/kubernetes.html

# Kubernetes cheat sheet

- https://kubernetes.io/docs/reference/kubectl/cheatsheet/

Command to seek k8s inside namespace created by Drakkar. Namespaces always start with "branch-" followed by branch name.

```
kubectl get pods --namespace branch-${BRANCH_NAME}
kubectl get pods -n branch-${BRANCH_NAME}
```

```
kubectl get service --namespace branch-${BRANCH_NAME}
kubectl get svc -n branch-${BRANCH_NAME}
```

To have more info about K8S resource:

```
kubectl describe pod -n branch-${BRANCH_NAME}
kubectl describe svc -n branch-${BRANCH_NAME}
```

To see logs inside a container:

```
kubectl logs $(pod-id) -n branch-${BRANCH_NAME}
```

To execute a shell inside a container:

```
kubectl exec -it $(pod-id) -n branch-${BRANCH_NAME} -- sh
```

Self explainatory:

```
kubectl get pods --all-namespaces
```

```
kubectl get deployment -n branch-${BRANCH_NAME}
```

```
kubectl get ingressroute -n branch-${BRANCH_NAME}
```

```
kubectl get secret -n branch-${BRANCH_NAME}
```

```
kubectl get certificate -n branch-${BRANCH_NAME}
```