resource "aws_iam_policy" "certManagerPolicy" {
  name        = "certManagerRoute53Policy"
  path        = "/"
  description = ""

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
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
            "Resource": "arn:aws:route53:::hostedzone/${var.Route53HostedZoneID}"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ListHostedZonesByName",
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_policy" "DevBackendSecret" {
  name        = "DevBackendConfigReadAccess"
  path        = "/"
  description = ""

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "secretsmanager:GetSecretValue",
            "Resource": "${aws_secretsmanager_secret.devConfigBackendSecret.arn}"
        }
    ]
  })
  depends_on = [
    aws_secretsmanager_secret.devConfigBackendSecret
  ]
}

resource "aws_iam_policy" "DevMongodbSecret" {
  name        = "DevMongodbConfigReadAccess"
  path        = "/"
  description = ""

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "secretsmanager:GetSecretValue",
            "Resource": "${aws_secretsmanager_secret.devConfigMongodbSecret.arn}"
        }
    ]
  })
  depends_on = [
    aws_secretsmanager_secret.devConfigMongodbSecret
  ]
}