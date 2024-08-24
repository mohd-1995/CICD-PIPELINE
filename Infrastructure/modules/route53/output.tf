output "zone_id" {
  value = aws_route53_zone.domain.zone_id
}


output "name_servers" {
  value = aws_route53_zone.domain.name_servers
}
