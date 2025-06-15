# outputs.tf

output "cloudtrail_trail_arn" {
  value       = aws_cloudtrail.this.arn
  description = "ARN of the CloudTrail trail"
}

output "cloudtrail_bucket_name" {
  value       = aws_s3_bucket.cloudtrail_logs.bucket
  description = "Name of the S3 bucket for CloudTrail logs"
}

output "cloudtrail_kms_key_arn" {
  value       = aws_kms_key.cloudtrail.arn
  description = "ARN of the KMS key for encryption"
}
