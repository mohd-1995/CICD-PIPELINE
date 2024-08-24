
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block           = "10.0.0.0/16"
  instance_tenancy         = "default"
  enable_dns_hostnames     = true
  enable_dns_support       = true
  vpc_name                 = "My VPC for the website"
  igw_name                 = "My VPC IGW"
  subnet1_cidr_block       = "10.0.1.0/24"
  subnet1_az               = "eu-west-2a"
  subnet1_name             = "Public Subnet 1"
  subnet2_cidr_block       = "10.0.2.0/24"
  subnet2_az               = "eu-west-2b"
  subnet2_name             = "Public Subnet 2"
  map_public_ip_on_launch  = true
  route_table_name         = "Route to internet"
  vpc_log_group_name       = "/aws/vpc/flow-logs"
  vpc_flow_logs_role_name  = "vpc_flow_logs_role"
  vpc_flow_logs_policy_name = "vpc_flow_logs_policy"
  traffic_type             = "ALL"
}


module "security_group" {
  source = "./modules/security-group"

  vpc_id      = module.vpc.vpc_id
  lb_sg_name  = "LoadBalancerSG"
  ec2_sg_name = "EC2InstanceSG"
}


module "route53" {
  source = "./modules/route53"
  domain_name = "moesportfolio.com"
}


module "alb" {
  source = "./modules/load-balancer"

  lb_name                             = "my-lb"
  lb_internal                         = false
  lb_type                             = "application"
  lb_security_groups                  = [module.security_group.lb_sg_id]
  lb_subnets                          = [module.vpc.subnet1_id, module.vpc.subnet2_id]
  lb_enable_cross_zone_load_balancing = true
  lb_ip_address_type                  = "ipv4"

  tg_name                             = "my-target-group"
  tg_port                             = 80
  tg_protocol                         = "HTTP"
  tg_vpc_id                           = module.vpc.vpc_id
  tg_health_check_enabled             = true
  tg_health_check_interval            = 30
  tg_health_check_path                = "/index.html"
  tg_health_check_port                = "traffic-port"
  tg_health_check_protocol            = "HTTP"
  tg_health_check_healthy_threshold   = 3
  tg_health_check_unhealthy_threshold = 2
  tg_health_check_timeout             = 3
  tg_health_check_matcher             = "200"

  listener_port                       = 80
  listener_protocol                   = "HTTP"
}


###asg

module "asg" {
  source = "./modules/autoscaling"

  launch_configuration_name_prefix = "web-launch-"
  image_id                         = "ami-09d6bbc1af02c2ca1"
  instance_type                    = "t2.micro"
  security_groups                  = [module.security_group.lb_sg_id]
  key_name                         = "moe-dev"
  iam_instance_profile             = module.sns.iam_instance_profile_name
  user_data                        = "user-data.sh" 
  autoscaling_group_name_prefix    = "asg-tf-"
  vpc_zone_identifier              = [module.vpc.subnet1_id, module.vpc.subnet2_id]
  min_size                         = 1
  max_size                         = 2
  desired_capacity                 = 1
  autoscaling_group_name_tag       = "web-asg"
  health_check_type                = "EC2"
  health_check_grace_period        = 300
  target_group_arns                = [module.alb.tg_arn]
}



module "sns" {
  source = "./modules/sns"

  sns_topic_name           = "docker-pull-notification"
  iam_role_name            = "ec2-sns-role-unique"
  iam_policy_name          = "ec2-sns-policy-unique"
  sns_topic_arn            = "arn:aws:sns:eu-west-2:915228257337:docker-pull-notification"
  iam_instance_profile_name = "ec2-sns-profile"
  email_endpoint           = "balouch177@gmail.com"
}

