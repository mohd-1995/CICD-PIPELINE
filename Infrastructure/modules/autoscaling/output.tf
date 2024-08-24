output "launch_configuration_id" {
  value = aws_launch_configuration.web.id
}

output "autoscaling_group_id" {
  value = aws_autoscaling_group.web.id
}


