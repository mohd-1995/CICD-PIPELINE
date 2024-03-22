resource "aws_launch_configuration" "web" {
  name_prefix   = "web-launch-"
  image_id      = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.ec2.id]
  key_name = "key"
  #new attached
  iam_instance_profile = aws_iam_instance_profile.sns-profile.name
  user_data = file("user-data.sh")
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name_prefix = "asg-tf-"
  launch_configuration = aws_launch_configuration.web.id
  vpc_zone_identifier  = [ aws_subnet.s1.id, aws_subnet.s2.id ]
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = true
  }

  health_check_type          = "EC2"
  health_check_grace_period  = 300
  target_group_arns          = [aws_lb_target_group.tg.arn]
}
