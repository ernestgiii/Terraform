module "cloudtrail_logging" {
  source          = "../modules/cloudtrail-logging"
  aws_region      = var.aws_region
  cloudtrail_name = var.cloudtrail_name
  s3_bucket_name  = var.s3_bucket_name
  environment     = var.environment
} 