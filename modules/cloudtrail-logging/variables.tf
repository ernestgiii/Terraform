# variables.tf

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default = "us-east-1"
}

variable "cloudtrail_name" {
  description = "Name for the CloudTrail trail"
  type        = string
  default = "main-org-cloudtrail"
}

variable "s3_bucket_name" {
  description = "S3 bucket name for CloudTrail logs"
  type        = string
  default = "my-org-cloudtrail-logs-v1"
}

variable "environment" {
  description = "Environment tag for resources (e.g., prod, dev)"
  type        = string
  default     = "prod"
}
