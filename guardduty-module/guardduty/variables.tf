variable "finding_publishing_frequency" {
  type        = string
  description = "Frequency of findings: FIFTEEN_MINUTES | ONE_HOUR | SIX_HOURS"
  default     = "ONE_HOUR"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to GuardDuty detector"
  default     = {}
}

variable "s3_protection_enabled" {
  type        = bool
  description = "Enable S3 protection for GuardDuty"
  default     = true
}

variable "enable" {
  description = "Enable GuardDuty detector"
  default     = true
}