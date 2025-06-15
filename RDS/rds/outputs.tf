output "endpoint" {
  description = "DB connection endpoint"
  value       = aws_db_instance.this.endpoint
}

output "port" {
  description = "DB port"
  value       = aws_db_instance.this.port
}
