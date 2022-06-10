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

## Security groups traffic rules

- EKS (Control Plane) in/out: 0 - 65535
- Nodes ingress control plane: 1025 - 65535
- Nodes egress: 0 - 0
- Nodes internal: 0 - 65535
- Public subnet ingress: 80 / 443
- Public subnet egress: 0

## Missions

#### Mission 1:
Créer un cluster EKS pour aller faire tourner la CI

#### Mission 2:
Mettre en place les tests de front (et back)

#### Mission 3:
Mettre en place les environnements de test avec une architecture complète (avec auto-nettoyage de l'environnement)

#### Mission 4:
Mettre en place la gestion des secrets ?

#### Mission 5:
Mettre en place la prod + pré prod avec deployment one-click

#### Mission 6:
Faire test de montee en charge avec k6s

### Useful Links

- https://medium.com/devops-mojo/terraform-provision-amazon-eks-cluster-using-terraform-deploy-create-aws-eks-kubernetes-cluster-tf-4134ab22c594

- https://aws.plainenglish.io/ci-cd-with-gitlab-kubernetes-eks-and-helm-a3667b0fb8ed

- https://wahlnetwork.com/2020/09/22/gitlab-ci-runners-on-amazon-eks-using-terraform/

- https://marcincuber.medium.com/kubernetes-gitlab-runners-on-amazon-eks-5ba7f0bff30e

- https://github.com/npalm/terraform-aws-gitlab-runner

- https://040code.github.io/2017/12/09/runners-on-the-spot

- https://about.gitlab.com/blog/2017/11/23/autoscale-ci-runners/

- https://adambcomer.com/blog/install-gitlab-runner-kubernetes/

- https://github.com/DeimosCloud/terraform-kubernetes-gitlab-runner