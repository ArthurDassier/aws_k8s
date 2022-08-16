# EKS Cluster

V1 du cluster K8S

## Stack 

### Infra
  - [AWS](https://aws.amazon.com/)
  - [Docker](https://www.docker.com/)
  - [Kubernetes](https://kubernetes.io/)
  - [EKS](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
  - [Terraform](https://nodejs.org/en/)
### Apps
  - [GitLab](https://gitlab.com/)
  - [Kaniko](https://cloud.google.com/blog/products/containers-kubernetes/introducing-kaniko-build-container-images-in-kubernetes-and-google-container-builder-even-without-root-access)


## Required programs
- Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Install [Git](https://git-scm.com/downloads)
- Install an IDE (we recommand [Visual Studio Code](https://code.visualstudio.com/Download))

HELM

## Configure your environment

### AWS CLI
You must set your [AWS Credentials properly](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

Create a user with a key at the parent level with admin policies to get a key and store it in `~/.aws/credentials`

eu-west-3

### Deploying an EKS and our MVA (Minimal Viable Architecture)

You must start by deploying the EKS via Terraform, follow the doc inside the [terraform](./terraform#terraform) folder. You can then follow the markdown doc of every app stored in the [kubernetes](./kubernetes#kubernetes) folder in the following order.

1) [gitlab-runner](./kubernetes/gitlab-runner/#gitlab-runner)
2) [traefik](./kubernetes/traefik/#traefik)
3) [cert-manager](./kubernetes/cert-manager/#cert-manager)
4) [secret-store](./kubernetes/secrets-store-csi-driver/#secret-store)

### Kubectl
To set up your kubectl to use your AWS credentials and connect to the EKS control plane, use the following command:

```bash
$ aws eks update-kubeconfig --region eu-west-3 --name <cluster-name>
```
In case of AWS STS error “the security token included in the request is expired” that means you probably have 2FA on your AWS account, you need to retrive new keys and use them in lieu of you old credentials, usually stored in `~/.aws/credentials`. To retrieve you new keys for the day use:

```bash
$ aws sts get-session-token --serial-number <serial number> --token-code <token-code>
```
`<token-code>` refers to your 2FA generated token.

More info [here](https://aws.amazon.com/premiumsupport/knowledge-center/sts-iam-token-expired/) and [here](https://bobbyhadz.com/blog/aws-cli-security-token-included-request-invalid)
