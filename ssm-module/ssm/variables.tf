variable "name" {
  description = "Name of the parameter"
  type        = string
  default = "/app/dev/db_password"
}

variable "type" {
  description = "SSM parameter type: SecureString or String"
  type        = string
  default     = "SecureString"
}

variable "tier" {
  description = "SSM parameter tier"
  type        = string
  default     = "Standard"
}

variable "overwrite" {
  description = "Whether to overwrite existing parameter"
  type        = bool
  default     = false
}

variable "value" {
  description = "Value of the parameter"
  type        = string
  default     = "default_password"
}

