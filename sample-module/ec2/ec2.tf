variable "ec2" {
    type = string 
}

resource "aws_instance" "webec2" {
  ami             = "ami-02238ac43d6385ab3"
  instance_type   = "t2.micro"
  tags = {
    Name = var.ec2
  }
}

output "instance_id" {
    value = aws_instance.webec2.id
}