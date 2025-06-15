variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "force_destroy" {
  description = "Allow force deletion of non-empty bucket"
  type        = bool
  default     = false
}

variable "retention_mode" {
  description = "Object lock mode: GOVERNANCE or COMPLIANCE"
  type        = string
  default     = "GOVERNANCE"
}

variable "retention_days" {
  description = "How many days to retain objects"
  type        = number
  default     = 7
}
