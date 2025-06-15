provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "dbec2" {
  ami           = "ami-02238ac43d6385ab3"
  instance_type = "t2.micro" #Free tier eligible
  count = 3

  tags = {
    Name = "DB Server"
  }

}