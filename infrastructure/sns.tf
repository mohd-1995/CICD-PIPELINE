resource "aws_sns_topic" "sns" {
  name = "docker-pull-notification"


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "sns-role" {
  name = "ec2-sns-role"

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

resource "aws_iam_policy" "sns-policy" {
  name        = "ec2-sns-policy"
  description = "EC2 policy for SNS and SSM"

  lifecycle {
    create_before_destroy = true
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sns:Publish",  // Added action
          "sns:Subscribe",
          "sns:Receive",
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:Publish"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:sns:eu-west-2:768983712348:docker-pull-notification"
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "sns-policy-attach" {
  role       = aws_iam_role.sns-role.name
  policy_arn = aws_iam_policy.sns-policy.arn

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "sns-profile" {
  name = "ec2-sns-profile"
  role = aws_iam_role.sns-role.name

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.sns.arn
  protocol = "email"
  endpoint = "balouch177@gmail.com"

  lifecycle {
    create_before_destroy = true
  }
}


output "sns-topic-arn" {
  value = aws_sns_topic.sns.arn
}