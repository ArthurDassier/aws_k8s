FROM ubuntu:latest

ARG AWS_VERSION="2.7.6"
ARG KUBE_VERSION="v1.24.0"

RUN apt-get update \
  && apt-get install -y ca-certificates curl unzip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip

RUN curl --silent -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 &&  chmod +x /usr/local/bin/kubectl