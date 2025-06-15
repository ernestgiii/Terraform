variable "allocated_storage" {
  description = "DB storage in GB"
  type        = number
  default     = 20
}

variable "engine" {
  description = "DB engine (mysql, postgres, etc.)"
  type        = string
}

variable "engine_version" {
  description = "DB engine version"
  type        = string
}

variable "instance_class" {
  description = "DB instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  
}

variable "username" {
  description = "Master username"
  type        = string
  default = "demo-admin"  # Default username for demo purposes
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "Port to connect"
  type        = number
  default     = 5432
}

variable "db_subnet_group_name" {
  description = "Subnet group name for RDS"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Whether the DB is publicly accessible"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {}
}
