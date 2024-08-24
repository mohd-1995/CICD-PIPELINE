variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
  default     = "my-lb"
}

variable "lb_internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "The type of the load balancer"
  type        = string
  default     = "application"
}

variable "lb_security_groups" {
  description = "The security groups to attach to the load balancer"
  type        = list(string)
}

variable "lb_subnets" {
  description = "The subnets to attach to the load balancer"
  type        = list(string)
}

variable "lb_enable_cross_zone_load_balancing" {
  description = "Whether to enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "lb_ip_address_type" {
  description = "The IP address type for the load balancer"
  type        = string
  default     = "ipv4"
}

variable "tg_name" {
  description = "The name of the target group"
  type        = string
  default     = "my-target-group"
}

variable "tg_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}

variable "tg_protocol" {
  description = "The protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "tg_vpc_id" {
  description = "The VPC ID for the target group"
  type        = string
}

variable "tg_health_check_enabled" {
  description = "Whether health checks are enabled"
  type        = bool
  default     = true
}

variable "tg_health_check_interval" {
  description = "The interval between health checks"
  type        = number
  default     = 30
}

variable "tg_health_check_path" {
  description = "The path for health checks"
  type        = string
  default     = "/index.html"
}

variable "tg_health_check_port" {
  description = "The port for health checks"
  type        = string
  default     = "traffic-port"
}

variable "tg_health_check_protocol" {
  description = "The protocol for health checks"
  type        = string
  default     = "HTTP"
}

variable "tg_health_check_healthy_threshold" {
  description = "The number of consecutive health check successes required before considering an unhealthy target healthy"
  type        = number
  default     = 3
}

variable "tg_health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  type        = number
  default     = 2
}

variable "tg_health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  type        = number
  default     = 3
}

variable "tg_health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target"
  type        = string
  default     = "200"
}

variable "listener_port" {
  description = "The port for the listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "The protocol for the listener"
  type        = string
  default     = "HTTP"
}
