# Outputs for Security Groups

output "lb_sg_id" {
  description = "The ID of the security group for the load balancer"
  value       = aws_security_group.lb.id
}

output "ec2_sg_id" {
  description = "The ID of the security group for EC2 instances"
  value       = aws_security_group.ec2.id
}
    