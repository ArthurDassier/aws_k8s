# Provision Amazon EKS Cluster using Terraform

## Create the EKS cluster

You need to run those commands inside the `terraform` folder.

Initialize terraform configuration

```
terraform init
```

Validate terraform configuration

```
terraform validate
```

Create terraform plan

```
terraform plan -out state.tfplan
```

Apply terraform plan

```
terraform apply state.tfplan
```

## Set up AWS CLI

To set up your kubectl to use your AWS credentials and connect to the EKS control plane, use the command below.

`<cluster-name>` being the name set during the `terraform apply` command (for example `"my-eks"`), append with `"-cluster"`, giving us `my-eks-cluster`

```
aws eks update-kubeconfig --region eu-west-3 --name <cluster-name>
```

In case of AWS STS error “the security token included in the request is expired” that means you probably have 2FA on your AWS account, you need to retrive new keys and use them in lieu of you old credentials, usually stored in `~/.aws/credentials`. To retrieve you new keys for the day use the command below.

`<token-code>` refers to your 2FA generated token.

```bash
$ aws sts get-session-token --serial-number <serial number> --token-code <token-code>
```

More info: 
- https://aws.amazon.com/premiumsupport/knowledge-center/sts-iam-token-expired
- https://bobbyhadz.com/blog/aws-cli-security-token-included-request-invalid

## Network

There is an Internet Gateway to provide internet access for services within VPC.

The NAT Gateway exist in public subnets. It is used in private subnets to allow services to connect to the internet.

## Nodes

We are currently using four t2.small EC2 virtual machines. Two are deployed in public subnets and two are deployed in private subnets.

## Security groups traffic rules

- EKS (Control Plane) in/out: 0 - 65535
- Nodes ingress control plane: 1025 - 65535
- Nodes egress: 0 - 0
- Nodes internal: 0 - 65535
- Public subnet ingress: 80 / 443
- Public subnet egress: 0

## Destroy the environment *DANGEROUS!* 

```
terraform destroy -auto-approve
```

## Useful Links

### Terraform doc

- https://www.terraform.io/docs

### Provision Amazon EKS Cluster using Terraform

- https://medium.com/devops-mojo/terraform-provision-amazon-eks-cluster-using-terraform-deploy-create-aws-eks-kubernetes-cluster-tf-4134ab22c594
