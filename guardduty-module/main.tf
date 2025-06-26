module "guardduty" {
  source                      = "../guarduty-module/guardduty"
  finding_publishing_frequency = var.finding_publishing_frequency
  tags = {
    Name        = var.tags
  }
}