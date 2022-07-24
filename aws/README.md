# AWS Roles documentation

## User groups

- certManagerIAMUser

## Users

- certManagerIAMUser (Bound: certManagerIAMUser)
- gitlab-cd (Bound: CloudFrontFullAccess & AmazonS3FullAccess)

## Roles

These two roles were created by Terraform, they provides Kubernetes the permissions it requires to manage resources on our behalf.

    TerraformEKSLab-Cluster-Role
    TerraformEKSLab-Worker-Role

These two roles are bound to secret read access policies, they're also attached to a trust relationship with a IAM OIDC Provider which is an entitiy that can assume this role under specified conditions, in our case, a Kubernetes Service Account that specify which role it is using in its annotations.

    dev-mongodb-config-access
    dev-backend-config-access

## Policies

Route 53 get change, list and change Resource Record Sets and list Hosted Zones

    certManagerIAMUser

These policies confers reading access to secrets

#### dev/config/backend

    DevBackendConfigReadAccess

#### dev/config/mongodb

    DevMongodbConfigReadAccess


## Identity provider

- oidc.eks.eu-west-3.amazonaws.com/id/...