# Variables for Security Groups

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "lb_sg_name" {
  description = "Name of the security group for the load balancer"
  type        = string
  default     = "LoadBalancerSG"
}

variable "ec2_sg_name" {
  description = "Name of the security group for EC2 instances"
  type        = string
  default     = "EC2InstanceSG"
}

