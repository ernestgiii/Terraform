resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  port                 = var.port
  db_subnet_group_name = var.db_subnet_group_name

  vpc_security_group_ids = var.vpc_security_group_ids

  skip_final_snapshot   = true  # For demo, disables snapshot when destroyed
  publicly_accessible   = var.publicly_accessible

  # Optional: storage encryption, backup, multi-az, etc.
  storage_encrypted     = true
  backup_retention_period = 7

  tags = var.tags
}
