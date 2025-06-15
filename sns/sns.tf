provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_sns_topic" "encrypted_sns_topic" {
  name = "sns-demo"

  # Enabling server-side encryption with AWS-managed KMS key
  kms_master_key_id = "alias/aws/sns"  # AWS managed KMS key for SNS encryption
}

output "sns_topic_arn" {
  value = aws_sns_topic.encrypted_sns_topic.arn
}