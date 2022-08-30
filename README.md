# EKS Cluster

V2 du cluster K8S

## Stack 

### Infra
  - [AWS](https://aws.amazon.com/)
  - [Docker](https://www.docker.com/)
  - [Kubernetes](https://kubernetes.io/)
  - [EKS](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
  - [Terraform](https://nodejs.org/en/)
  - [Helm](https://helm.sh/)

### Apps
  - [GitLab](https://gitlab.com/)
  - [Kaniko](https://cloud.google.com/blog/products/containers-kubernetes/introducing-kaniko-build-container-images-in-kubernetes-and-google-container-builder-even-without-root-access)

## Required programs
- Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Install [Helm](https://helm.sh/docs/intro/install/)
- Install [Git](https://git-scm.com/downloads)
- Install an IDE (we recommand [Visual Studio Code](https://code.visualstudio.com/Download))

## Configure your environment

### AWS CLI
You must set your [AWS Credentials properly](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

Create a user with a key at the parent level with admin policies to get a key and store it in `~/.aws/credentials`

Your default region is eu-west-3 and the output format can be json for example.

### Deploying an EKS and our MVA (Minimal Viable Architecture)

You must start by deploying the EKS via Terraform, follow the doc inside the [terraform](./terraform#terraform) folder. You can then follow the markdown doc of every app stored in the [kubernetes](./kubernetes#kubernetes) folder in the following order.

* [terraform](./terraform#terraform)
* [kubernetes](./kubernetes#kubernetes)
  * [gitlab-runner](./kubernetes/gitlab-runner/#gitlab-runner)
  * [traefik](./kubernetes/traefik/#traefik)
  * [cert-manager](./kubernetes/cert-manager/#cert-manager)
  * [secret-store](./kubernetes/secrets-store-csi-driver/#secret-store)

## To follow if you are not the creator of the cluster

As mentioned in this [article](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html):

    When you create an Amazon EKS cluster, the IAM entity user or role (for example, for federated users) that creates the cluster is automatically granted system:master permissions in the cluster's RBAC configuration. To grant additional AWS users or roles the ability to interact with your cluster, you must edit the aws-auth ConfigMap within Kubernetes.

  1. Check if you have aws-auth ConfigMap applied to your cluster:

    kubectl describe configmap -n kube-system aws-auth

  2. If ConfigMap is present, skip this step and proceed to step 
  
  3. If ConfigMap is not applied yet, you should do the following:

Download the stock ConfigMap:

```
curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/aws-auth-cm.yaml
```

Adjust it using your NodeInstanceRole ARN in the `rolearn`: . To get NodeInstanceRole value check out [this manual](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html) and you will find it at steps 3.8 - 3.10.

```
data:
  mapRoles: |
    - rolearn: <ARN of instance role (not instance profile)>
```

Apply this config map to the cluster:

    kubectl apply -f aws-auth-cm.yaml

Wait for cluster nodes becoming Ready:

    kubectl get nodes --watch

Edit aws-auth ConfigMap and add users to it according to the example below:
```
kubectl edit -n kube-system configmap/aws-auth
```
```
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
data:
  mapRoles: |
    - rolearn: arn:aws:iam::555555555555:role/devel-worker-nodes-NodeInstanceRole-74RF4UBDUKL6
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
  mapUsers: |
    - userarn: arn:aws:iam::555555555555:user/admin
      username: admin
      groups:
        - system:masters
    - userarn: arn:aws:iam::111122223333:user/ops-user
      username: ops-user
      groups:
        - system:masters
```

Save and exit the editor.

  4. Create kubeconfig for your IAM user following [this manual](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html).

