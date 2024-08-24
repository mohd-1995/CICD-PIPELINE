variable "launch_configuration_name_prefix" {
  description = "Prefix for the launch configuration name"
  type        = string
}

variable "image_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "user_data" {
  description = "Path to the user data script"
  type        = string
}

variable "autoscaling_group_name_prefix" {
  description = "Prefix for the autoscaling group name"
  type        = string
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum size of the autoscaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the autoscaling group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of the autoscaling group"
  type        = number
}

variable "autoscaling_group_name_tag" {
  description = "Name tag for the autoscaling group"
  type        = string
}

variable "health_check_type" {
  description = "Health check type for the autoscaling group"
  type        = string
}

variable "health_check_grace_period" {
  description = "Health check grace period for the autoscaling group"
  type        = number
}

variable "target_group_arns" {
  description = "List of target group ARNs"
  type        = list(string)
}
