provider "aws" {
  region = "us-east-1"
}

module "s3_object_lock" {
  source          = "../s3-object-lock-module/s3-object-lock"
  bucket_name     = "my-secure-locked-bucket-001"
  retention_mode  = "GOVERNANCE"
  retention_days  = 7
}