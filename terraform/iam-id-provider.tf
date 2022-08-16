data "tls_certificate" "default" {
  url = aws_eks_cluster.this.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "default" {
  url = aws_eks_cluster.this.identity.0.oidc.0.issuer

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [data.tls_certificate.default.certificates.0.sha1_fingerprint]
}