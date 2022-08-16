# Provision Amazon EKS Cluster using Terraform

To set up your kubectl to use your AWS credentials and connect to the EKS control plane, use the following command:

```
aws eks update-kubeconfig --region eu-west-3 --name <cluster-name>
```

## Create the EKS cluster

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

Cleanup

```
terraform destroy -auto-approve
```

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

## Useful Links

### Terraform doc

- https://www.terraform.io/docs

### Provision Amazon EKS Cluster using Terraform

- https://medium.com/devops-mojo/terraform-provision-amazon-eks-cluster-using-terraform-deploy-create-aws-eks-kubernetes-cluster-tf-4134ab22c594
