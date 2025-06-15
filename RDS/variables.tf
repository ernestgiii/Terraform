# root variables for RDS module
variable "db_username" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "RDS subnet group name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs for RDS"
  type        = list(string)
}
