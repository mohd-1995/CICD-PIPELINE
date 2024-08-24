resource "aws_launch_configuration" "web" {
  name_prefix   = var.launch_configuration_name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type
  security_groups = var.security_groups
  key_name = var.key_name
  iam_instance_profile = var.iam_instance_profile
  user_data = file("${path.module}/${var.user_data}")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name_prefix = var.autoscaling_group_name_prefix
  launch_configuration = aws_launch_configuration.web.id
  vpc_zone_identifier  = var.vpc_zone_identifier
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = var.autoscaling_group_name_tag
    propagate_at_launch = true
  }

  health_check_type          = var.health_check_type
  health_check_grace_period  = var.health_check_grace_period
  target_group_arns          = var.target_group_arns
}
