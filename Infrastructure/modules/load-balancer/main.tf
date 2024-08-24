resource "aws_lb" "lb" {
  name                             = var.lb_name
  internal                         = var.lb_internal
  load_balancer_type               = var.lb_type
  security_groups                  = var.lb_security_groups
  subnets                          = var.lb_subnets
  enable_cross_zone_load_balancing = var.lb_enable_cross_zone_load_balancing
  ip_address_type                  = var.lb_ip_address_type

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.tg_vpc_id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    enabled             = var.tg_health_check_enabled
    interval            = var.tg_health_check_interval
    path                = var.tg_health_check_path
    port                = var.tg_health_check_port
    protocol            = var.tg_health_check_protocol
    healthy_threshold   = var.tg_health_check_healthy_threshold
    unhealthy_threshold = var.tg_health_check_unhealthy_threshold
    timeout             = var.tg_health_check_timeout
    matcher             = var.tg_health_check_matcher
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
