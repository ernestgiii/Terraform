# The password  has to be passed as a variable, not hardcoded when running terraform apply.
resource "aws_ssm_parameter" "this" {
  name      = var.name
  type      = var.type
  tier      = var.tier
  overwrite = var.overwrite
  value     = var.value

  tags = {
    Environment = "dev"
    Demo        = "Software"
  }

  key_id = var.type == "SecureString" ? aws_kms_key.ssm_key[0].arn : null
}

  

# Create a KMS key only if SecureString is used
resource "aws_kms_key" "ssm_key" {
  count       = var.type == "SecureString" ? 1 : 0
  description = "KMS key for encrypting SSM SecureString parameters"
  enable_key_rotation = true

  tags = {
    Name = "ssm-secrets-key"
  }
}
