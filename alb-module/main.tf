provider "aws" {
  region = "us-east-2"
}

module "alb_module" {
  source  = "./alb-module"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  desired_capacity   = var.desired_capacity
  min_size           = var.min_size
  max_size           = var.max_size
}
