# Outputs 

output "db_instance_endpoint" {
  value     = aws_db_instance.demords
  sensitive = true
}