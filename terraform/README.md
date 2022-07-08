# Provision Amazon EKS Cluster using Terraform

Initialize terraform configuration
```bash
terraform init
```

Validate terraform configuration
```bash
terraform validate
```

Create terraform plan
```bash
terraform plan -out state.tfplan
```

Apply terraform plan
```bash
terraform apply state.tfplan
```

Cleanup
```bash
terraform destroy -auto-approve
```

```bash
$ aws sts get-session-token --serial-number <serial number> --token-code <token-code>
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
