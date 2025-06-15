variable "aws_region" {
  description = "This is where the region of the ECR repo will be located at."
  type = string
}

variable "ecr_repo_name" {
  description = "This is the name of the ECR repo."
  type = string
}
