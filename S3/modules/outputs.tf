output "bucket_id" {
  description = "The name of the bucket"
  value       = aws_bucket.this.id
  
}

output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_bucket.this.arn
}