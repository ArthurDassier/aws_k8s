resource "aws_iam_role" "dev-backend-config-access" {
  name = "dev-backend-config-access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.default.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${aws_iam_openid_connect_provider.default.url}:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
  })
  depends_on = [
    aws_iam_openid_connect_provider.default
  ]
}

resource "aws_iam_role" "dev-mongodb-config-access" {
  name = "dev-mongodb-config-access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.default.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${aws_iam_openid_connect_provider.default.url}:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backendAttached" {
  policy_arn = aws_iam_policy.DevBackendSecret.arn
  role       = aws_iam_role.dev-backend-config-access.name
}

resource "aws_iam_role_policy_attachment" "mongodbAttached" {
  policy_arn = aws_iam_policy.DevMongodbSecret.arn
  role       = aws_iam_role.dev-mongodb-config-access.name
}