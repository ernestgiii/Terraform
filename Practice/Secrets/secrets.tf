provider "aws" {
  region = "us-east-1"
}

resource "aws_kms_key" "my_kms_key" {
  description             = "kms key for demo credentials rotation"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_secretsmanager_secret" "demo_credentials" {
  name       = "demo-credentials"
  kms_key_id = aws_kms_key.my_kms_key.key_id
}

resource "aws_secretsmanager_secret_version" "demo_credentials" {
  secret_id = aws_secretsmanager_secret.demo_credentials.id
  secret_string = jsonencode({
    username = "admin",
    password = "passw0rd"
  })
}