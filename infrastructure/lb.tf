resource "aws_lb" "lb" {
  name                             = "my-lb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.lb.id]
  subnets                          = [aws_subnet.s1.id, aws_subnet.s2.id]
  enable_cross_zone_load_balancing = true
  ip_address_type                  = "ipv4"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "my-target-group" 
  port     = 80
  protocol = "HTTP" #tfsec:ignore:aws-elb-http-not-used
  vpc_id   = aws_vpc.vpc.id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    enabled             = true
    interval            = 30
    path                = "/index.html"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 3
    matcher             = "200"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}