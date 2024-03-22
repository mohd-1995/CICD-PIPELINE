resource "aws_route53_zone" "domain" {
  name = "moesportfolio.com"

  lifecycle {
    create_before_destroy = true
  }
}

