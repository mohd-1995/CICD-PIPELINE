resource "aws_route53_zone" "domain" {
  name = var.domain_name

  lifecycle {
    create_before_destroy = true
  }
}
