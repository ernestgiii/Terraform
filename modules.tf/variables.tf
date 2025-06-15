variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {
  default = "us-east-1" # Change this to your desired AWS region
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0e731c8a588258d0d"
}

variable "key_name" {
  description = "samplekey"
}

variable "subnet_id" {
  description = "ID of the subnet of the instance"
  default     = "default"
}

variable "tags" {
  type = map(string)
  default = {
    Name = "nginx-instance"
  }
}