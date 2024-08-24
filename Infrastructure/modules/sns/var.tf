# modules/sns_iam/main.tf
variable "sns_topic_name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "iam_policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile for SNS"
  type        = string
}

variable "email_endpoint" {
  description = "The email endpoint for SNS subscription"
  type        = string
}
