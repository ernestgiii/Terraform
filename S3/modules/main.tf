terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~> 4.8"
        }
    }
}

provider "aws" {
  region = "us-east-1"
}

module "name" {
  source = "./S3"
  bucket_name = "breezy-bucket"
  bucket_acl = "private"
  bucket_force_destroy = false
  tags = {
    Name = "breezy bucket"
  }
  
}