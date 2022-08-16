FROM ubuntu:latest

ARG AWS_VERSION="2.7.6"
ARG HELM_VERSION="v3.9.0"
ARG MONGO_TOOLS_VERSION="100.5.3"
ARG KUBE_VERSION="v1.24.0"

RUN apt-get update \
  && apt-get install -y ca-certificates curl unzip wget

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf aws awscliv2.zip

RUN curl -LO https://git.io/get_helm.sh \
 &&  chmod 700 get_helm.sh \
 &&  ./get_helm.sh --version ${HELM_VERSION} \
 &&  curl --silent -L https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator -o /usr/local/bin/aws-iam-authenticator \
 &&  chmod +x /usr/local/bin/aws-iam-authenticator \
 &&  rm -rf /tmp/*

RUN curl https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-${MONGO_TOOLS_VERSION}.deb -o mongotools.deb \
 && dpkg -i ./mongotools.deb \
 && rm -rf /mongotools.deb

RUN curl --silent -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 &&  chmod +x /usr/local/bin/kubectl