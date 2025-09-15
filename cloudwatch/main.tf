terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_log_group" "demo_log_group" {
  name = "/cloudwatch/logs"
  retention_in_days = 7 # tells us how long we want to keep log events in the specified log group.
}