
output "sns_topic_arn" {
  value = aws_sns_topic.sns.arn
}

output "sns_role_arn" {
  value = aws_iam_role.sns_role.arn
}


output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.sns_profile.name
}