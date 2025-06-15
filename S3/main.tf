terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.8"
    }
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  tags = var.tags

  force_destroy = var.bucket_force_destroy
}