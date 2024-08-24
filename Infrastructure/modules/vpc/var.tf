# VPC Variables
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "The instance tenancy option for the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "My VPC for the website"
}

# Internet Gateway Variables
variable "igw_name" {
  description = "The name of the Internet Gateway"
  type        = string
  default     = "My VPC IGW"
}

# Subnet Variables
variable "subnet1_cidr_block" {
  description = "The CIDR block for the first subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet1_az" {
  description = "The availability zone for the first subnet"
  type        = string
  default     = "eu-west-2a"
}

variable "subnet1_name" {
  description = "The name of the first subnet"
  type        = string
  default     = "Public Subnet 1"
}

variable "subnet2_cidr_block" {
  description = "The CIDR block for the second subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet2_az" {
  description = "The availability zone for the second subnet"
  type        = string
  default     = "eu-west-2b"
}

variable "subnet2_name" {
  description = "The name of the second subnet"
  type        = string
  default     = "Public Subnet 2"
}

variable "map_public_ip_on_launch" {
  description = "Map public IP on launch"
  type        = bool
  default     = true
}

# Route Table Variables
variable "route_table_name" {
  description = "The name of the route table"
  type        = string
  default     = "Route to internet"
}

# VPC Flow Logs Variables
variable "vpc_log_group_name" {
  description = "The name of the CloudWatch log group for VPC flow logs"
  type        = string
  default     = "/aws/vpc/flow-logs"
}

variable "vpc_flow_logs_role_name" {
  description = "The name of the IAM role for VPC flow logs"
  type        = string
  default     = "vpc_flow_logs_role"
}

variable "vpc_flow_logs_policy_name" {
  description = "The name of the IAM policy for VPC flow logs"
  type        = string
  default     = "vpc_flow_logs_policy"
}

variable "traffic_type" {
  description = "The type of traffic to log (ALL, ACCEPT, REJECT)"
  type        = string
  default     = "ALL"
}
