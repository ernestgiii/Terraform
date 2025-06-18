variable "ami_id" {
  type        = string
  description = "AMI ID to launch EC2 instances"
  default     = "ami-06971c49acd687c30"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number
  default     = 2
}

variable "desired_capacity" {
  type        = number
  default     = 1
}
