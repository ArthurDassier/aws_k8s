# Secret Manager

## CSI

The Secrets Store CSI Driver secrets-store.csi.k8s.io allows Kubernetes to mount secrets stored in our AWS secrets store into pods as a volume. Once the Volume is attached, the data in it is mounted into the container’s file system.

## Installation

```
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts

helm upgrade --install -n kube-system csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver -f secrets-store-csi-driver.values.yaml
```

```plantuml
storage Kubernetes {
node CSI #dodgerblue;text:white
collections secretProviderClass #dodgerblue;text:white;line:black
artifact secretFile #dodgerblue;text:white
collections deploymentStack #dodgerblue;text:white;line:black
node K8SAwsSecretManagerConfigProvider #dodgerblue;text:white
rectangle K8SServiceAccount #dodgerblue;text:white
}

storage AWS {
rectangle IAMIdentityProvider #darkorange
rectangle IAMRole #darkorange
rectangle IAMPolicy #darkorange
artifact AWSSecret #darkorange
}

CSI -[#black,dashed]-> secretProviderClass : create
secretProviderClass -[#black,dashed]-> secretFile : create
secretFile -[#black,dotted,thickness=5]-> deploymentStack : mount
secretProviderClass -[#black]-> K8SAwsSecretManagerConfigProvider : use
K8SAwsSecretManagerConfigProvider -[#black]-> K8SServiceAccount : use
K8SServiceAccount -[#black]-> IAMIdentityProvider : use
K8SServiceAccount -[#black]-> IAMRole : use
IAMIdentityProvider -[#black]-> IAMPolicy : linked
IAMRole -[#black]-> IAMPolicy : linked
IAMPolicy -[#black]-> AWSSecret : read
```

## How to mount a secret

Deployments retrieves secrets via a Service Account using an IAM role. Our secrets manager then mount the secret to the pod as a JSON-formatted secret file.

To mount the username and password key pairs of this secret as individual secrets, use the jmesPath field as follows:

```
spec:
  provider: aws
  secretObjects:
  - secretName: secret-name
    type: Opaque
    data:
    - objectName: username
      key: SECRET_ONE
    - objectName: password
      key: SECRET_TWO
    parameters:
      objects: |
        - objectName: "MySecret"
          objectType: "secretsmanager"
          jmesPath:
            - path: "USERNAME"
              objectAlias: username
            - path: "PASSWORD"
              objectAlias: password
```

It will split the secret into several files inside the container. One file corresponding to one secret, they're all made available as environment variables inside each container. To set the env in your deployment YAML:

```
env:
- name: USERNAME
    valueFrom:
    secretKeyRef:
        name: secret-name
        key: SECRET_ONE
- name: PASSWORD
    valueFrom:
    secretKeyRef:
        name: secret-name
        key: SECRET_TWO
```

## Official documentation

- https://docs.aws.amazon.com/eks/latest/userguide/manage-secrets.html
- https://secrets-store-csi-driver.sigs.k8s.io/

## Useful link

- https://www.youtube.com/watch?v=Rmgo6vCytsg

# AWS Secrets Manager and Config Provider for Secret Store CSI 

## Installation

```
kubectl apply -f aws-provider-installer.yaml
```

## Official documentation

- https://github.com/aws/secrets-store-csi-driver-provider-aws