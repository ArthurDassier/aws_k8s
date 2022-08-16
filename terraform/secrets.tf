resource "aws_secretsmanager_secret" "devConfigBackendSecret" {
  name = "dev/config/backend"
}

resource "aws_secretsmanager_secret" "devConfigMongodbSecret" {
  name = "dev/config/mongodb"
}

resource "aws_secretsmanager_secret_version" "secret_backend" {
    secret_id     = aws_secretsmanager_secret.devConfigBackendSecret.id
    secret_string = jsonencode({"Dark": "Vador"})
}

resource "aws_secretsmanager_secret_version" "secret_mongodb" {
    secret_id     = aws_secretsmanager_secret.devConfigMongodbSecret.id
    secret_string = jsonencode({"Kevin": "Costner"})
}