# Script deploys a domain in Route 53
provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "example_zone" {
  name = "aboutbreezy.com"
}

resource "aws_route53_record" "example_record" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = "www"
  type    = "A"
  ttl     = "60"
  records = ["1.2.3.4"]
}