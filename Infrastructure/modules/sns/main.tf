resource "aws_sns_topic" "sns" {
  name = var.sns_topic_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "sns_role" {
  name = var.iam_role_name

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "sns_policy" {
  name        = var.iam_policy_name
  description = "EC2 policy for SNS and SSM"

  lifecycle {
    create_before_destroy = true
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sns:Publish",
          "sns:Subscribe",
          "sns:Receive",
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:Publish"
        ],
        Effect   = "Allow",
        Resource = var.sns_topic_arn
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sns_policy_attach" {
  role       = aws_iam_role.sns_role.name
  policy_arn = aws_iam_policy.sns_policy.arn

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "sns_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.sns_role.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "email"
  endpoint  = var.email_endpoint

  lifecycle {
    create_before_destroy = true
  }
}