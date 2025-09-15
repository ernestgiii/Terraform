resource "aws_iam_role" "cloudwatch_agent_role" {
  name = "CloudWatchAgentRole"

  assume_role_policy = jsonencode({ 
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.cloudwatch_agent_role.name
}

# //resource "null_resource" "install_cloudwatch_agent" {
#   //provisioner "local-exec" {
#     //command = <<-EOF
#       wget https://amazoncloudwatch-agent.s3.amazonaws.com/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
#       sudo rpm -U ./amazon-cloudwatch-agent.rpm
#     EOF
#   }
# }

data "template_file" "cloudwatch_agent_config" {
  template = file("${path.module}/cloudwatch_agent_config.json.tpl")

  vars = {
    log_group_name = aws_cloudwatch_log_group.demo_log_group.name
  }
}

resource "aws_ssm_parameter" "cloudwatch_agent_config" {
  name  = "/cloudwatch-agent/config"
  type  = "String"
  value = data.template_file.cloudwatch_agent_config.rendered
}

resource "aws_instance" "example" {
  ami           = "ami-0b09ffb6d8b58ca91"  # Amazon Linux 2 AMI (adjust for your region)
  instance_type = "t2.micro" # adjust for your instance of choice
  
  iam_instance_profile = aws_iam_instance_profile.cloudwatch_agent_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y amazon-cloudwatch-agent
              /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:/cloudwatch-agent/config
              EOF

  tags = {
    Name = "DemoInstance" #include the tagging conventions of your org
  }
}

resource "aws_iam_instance_profile" "cloudwatch_agent_profile" {
  name = "CloudWatchAgentProfile"
  role = aws_iam_role.cloudwatch_agent_role.name
}