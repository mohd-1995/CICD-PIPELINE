output "lb_arn" {
  value = aws_lb.lb.arn
}

output "tg_arn" {
  value = aws_lb_target_group.tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}
