# docker-aws-cli-helm-mongodbtools 

We use our own Docker image to deploy a Drakkar app!

# What is awscli?

Awscli is the Amazon web services command line interface.

[Overview of awscli](https://docs.aws.amazon.com/cli/index.html)

# What is Helm?

Helm is the package manager for Kubernetes.

[Overview of helm](https://helm.sh/docs/)

# What is MongoDB Tools?

MongoDB Developer Tools provide ways to connect and work with a MongoDB database

[Overview of MongoDB Tools](https://www.mongodb.com/developer-tools)

# TL;DR;

```bash
docker run -ti --rm registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools
```

```bash
docker run -ti -e 'AWS_ACCESS_KEY_ID=********************' -e 'AWS_SECRET_ACCESS_KEY=****************************************' -v '/Users/statful/.kube:/root/.kube' --rm registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools helm list
```

```bash
docker run -ti -v '/Users/statful/.aws:/root/.aws' -v '/Users/statful/.kube:/root/.kube' --rm statful/awscli-helm helm listt
```

# Get this image

```bash
docker pull registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools:latest
```

To use a specific version, you can pull a versioned tag.

```bash
docker pull registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools:[TAG]
```

If you wish, you can also build the image yourself.

```bash
docker build -t registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools:latest
```

# Configuration

## Running commands

To run commands inside this container you can use `docker run`, for example to execute `helm --version` you can follow the example below:

```bash
docker run --rm --name helm registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools:latest -- helm version
```

Consult the [helm Reference Documentation](https://helm.sh/docs/) or the [AWS CLI Reference Documentation](https://docs.aws.amazon.com/cli/index.html) to find the completed list of commands available.

## AWS Credentials

AWS credentials can either be passed by environment variables, or by mounting a volume with aws credentials file under `/root/.aws`.

### Environment variables

```bash
docker run -ti -e 'AWS_ACCESS_KEY_ID=********************' -e 'AWS_SECRET_ACCESS_KEY=****************************************' --rm registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools aws s3 ls
```

### AWS directory

```bash
docker run -ti -v '/Users/statful/.aws:/root/.aws' --rm registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools aws s3
```

## Helm credentials

Helm credentials can be passed by mounting a volume with the kubeconfig under `/root/.kube`.

### Helm directory

```bash
docker run -ti -v '/Users/statful/.kube:/root/.kube' --rm registry.gitlab.com/alteregoart/maia/aws-cli-helm-mongodbtools helm get pods
```
