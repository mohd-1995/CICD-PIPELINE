#creating the VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "My VPC for the website"
  }
}

#creating internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

#Creating the 1st public subnet
resource "aws_subnet" "s1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "Public Subnet 1"
  }
}

#Creating the 2nd public subnet
resource "aws_subnet" "s2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "Public Subnet 2"
  }
}

#Creating the route table
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Route to internet"
  }
}

#creating the route table association for both subnets
resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.s1.id
  route_table_id = aws_route_table.route.id
}

#Creating the second public 
resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.s2.id
  route_table_id = aws_route_table.route.id
}


### vpc logs
resource "aws_cloudwatch_log_group" "vpc" {
  name = "/aws/vpc/flow-logs"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_flow_log" "vpc_flow" {
  iam_role_arn    = aws_iam_role.vpc_flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.vpc.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "vpc_flow_logs_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      },
    ]
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
  name = "vpc_flow_logs_policy"


  
  role = aws_iam_role.vpc_flow_logs_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = aws_cloudwatch_log_group.vpc.arn
      },
    ]
  })
}
