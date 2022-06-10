# EKS Cluster

V1 du cluster K8S


## Stack 

### Infra
  - [Docker](https://www.docker.com/)
  - [Kubernetes](https://kubernetes.io/)
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

## Configure your environment

### AWS CLI
You must set your [AWS Credentials properly](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).


### Kubectl
To set up your kubectl to use you AWS credentials and connect to the EKS control plance, use the following command:

```bash
$ aws eks update-kubeconfig --region eu-west-3 --name TerraformEKSLab-cluster
```
In case of AWS STS error “the security token included in the request is expired”:
```bash
$ aws sts get-session-token --serial-number <serial number> --token-code <token-code>
```

More info [here](https://aws.amazon.com/premiumsupport/knowledge-center/sts-iam-token-expired/) and [here](https://bobbyhadz.com/blog/aws-cli-security-token-included-request-invalid)
