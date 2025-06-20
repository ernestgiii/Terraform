module "db_password" {
  source     = "../ssm-module"
  name       = var.name
  type       = var.type
}
