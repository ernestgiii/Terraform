module "rds" {
  source = "./rds"

  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.3"
  instance_class         = "db.t3.micro"
  db_name                = "demodb"
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = false
  tags                   = { "project" = "rds-module-demo" }
}