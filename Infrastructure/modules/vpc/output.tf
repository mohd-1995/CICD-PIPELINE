# Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "subnet1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.subnet1.id
}

output "subnet2_id" {
  description = "The ID of the second public subnet"
  value       = aws_subnet.subnet2.id
}

output "route_table_id" {
  description = "The ID of the route table"
  value       = aws_route_table.route_table.id
}

output "vpc_flow_log_group_arn" {
  description = "The ARN of the CloudWatch log group for VPC flow logs"
  value       = aws_cloudwatch_log_group.vpc_log_group.arn
}

output "vpc_flow_logs_role_arn" {
  description = "The ARN of the IAM role for VPC flow logs"
  value       = aws_iam_role.vpc_flow_logs_role.arn
}
