resource "aws_instance" "ec2_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = var.subnet_id

  tags = var.tags
}

# provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/your-private-key.pem")
      host        = self.public_ip
    }
  
