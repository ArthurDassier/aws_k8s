# How to Install Cert-Manager

## TL;DR

    https://cert-manager.io/docs/installation/helm/#prerequisites

```
helm repo add jetstack https://charts.jetstack.io

helm repo update

kubectl create namespace cert-manager

helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.9.1 -f cert-manager.values.yaml --set installCRDs=true
```

`helm repo update` followed by `helm upgrade` command can also be used individually when you make change to the helm values YAML.

There is two YAML files that you need to apply manually, they need to be configured with the aws access key ID and secret key of a aws user attached to this aws policy:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "route53:GetChange",
            "Resource": "arn:aws:route53:::change/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets",
                "route53:ListResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/YOUR_ZONE"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ListHostedZonesByName",
            "Resource": "*"
        }
    ]
}
```

Run these commands:

```
kubectl apply -f cert-manager.clusterissuer.yaml
kubectl apply -f cert-manager.aws-secret.yaml
```

## Let’s Encrypt rate limits

Let’s Encrypt have rate limits, for testing purpose you should use let's encrypt staging server (ACME server to use in ClusterIssuer yaml). These certificates won't be trusted by most external parties.

- https://letsencrypt.org/docs/rate-limits/

## Official documentation

- https://cert-manager.io/docs/

## Official GitHub repository

- https://github.com/cert-manager/cert-manager

## Useful link

- https://www.youtube.com/watch?v=hoLUigg4V18
- https://blog.crafteo.io/2021/11/26/traefik-high-availability-on-kubernetes-with-lets-encrypt-cert-manager-and-aws-route53/
- https://stackoverflow.com/questions/35969976/amazon-aws-route-53-hosted-zone-does-not-work