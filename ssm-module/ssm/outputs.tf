output "parameter_name" {
  value = aws_ssm_parameter.this.name
}

output "parameter_arn" {
  value = aws_ssm_parameter.this.arn
}

output "kms_key_arn" {
  value = var.type == "SecureString" ? aws_kms_key.ssm_key[0].arn : null
}
