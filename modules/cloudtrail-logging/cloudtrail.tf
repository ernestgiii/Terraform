# main.tf

provider "aws" {
  region = var.aws_region
}

# 1. KMS Key for Encryption

resource "aws_kms_key" "cloudtrail" {
  description         = "KMS key for encrypting CloudTrail logs"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms_policy.json
}

# Create an alias for easier reference in the console
resource "aws_kms_alias" "cloudtrail" {
  name          = "alias/cloudtrail"
  target_key_id = aws_kms_key.cloudtrail.id
}

# Policy allowing CloudTrail and your account to use the key
data "aws_iam_policy_document" "kms_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  # Allow CloudTrail to use the key
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }
}

data "aws_caller_identity" "current" {}


# 2. S3 Bucket for CloudTrail

resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = var.s3_bucket_name
  
  tags = {
    Name        = "cloudtrail-logs"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.cloudtrail.arn
    }
  }
}


# 3. S3 Bucket Policy (let's CloudTrail write logs)

data "aws_iam_policy_document" "cloudtrail_s3_policy" {
  statement {
    sid     = "AWSCloudTrailAclCheck"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [aws_s3_bucket.cloudtrail_logs.arn]
  }
  statement {
    sid     = "AWSCloudTrailWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["${aws_s3_bucket.cloudtrail_logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_logs_policy" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  policy = data.aws_iam_policy_document.cloudtrail_s3_policy.json
}


# 4. CloudTrail Trail

resource "aws_cloudtrail" "this" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
  kms_key_id                    = aws_kms_key.cloudtrail.arn
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_logging                = true

  depends_on = [aws_s3_bucket_policy.cloudtrail_logs_policy]
}
