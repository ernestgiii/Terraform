# main tf file

# Define our provider

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Creating the RDS Instance
resource "aws_db_instance" "demords" {
  engine              = "Postgres"
  identifier          = "demords"
  allocated_storage   = "20"
  engine_version      = "15.4"
  instance_class      = "db.t3.micro"
  username            = "postgres"
  password            = "admin123"
  skip_final_snapshot = true
  publicly_accessible = true
}