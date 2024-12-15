# #Backend Configuration
# variable "region" {
#   type    = string
#   default = "ap-south-1"
# }

# variable "bucket" {
#   type = string
# }

# variable "key" {
#   type = string
# }

#Environment
variable "environment" {
  type = string
}


#Launch Template
# variable "lt_name" {
#   type = string
# }

# variable "instance_type" {
#   type = string
# }

# variable "key_name" {
#   type = string
# }

# variable "user_data_path" {
#   type = string
# }




#ASG
# variable "asg_name" {
#   type = string
# }

# variable "desired_capacity" {
#   type = number
# }
# variable "max_size" {
#   type = number
# }
# variable "min_size" {
#   type = number
# }

# variable "health_check_type" {
#   type = string
# }

# variable "launch_template_version" {
#   type = string
# }

# variable "strategy" {
#   type = string
# }

#TG
# variable "app_tg_name" {
#   type = string
# }
# variable "app_tg_port" {
#   type = number
# }
# variable "app_tg_protocol" {
#   type = string
# }
# variable "deregistration_delay" {
#   type = number
# }

# ELB
# variable "lb_name" {
#   type = string
# }

# variable "lb_type" {
#   type = string
# }

# variable "demo_app_listener_protocol" {
#   type = string
# }

# variable "demo_app_listener_port" {
#   type = number
# }




#Security Group
# variable "sg_name" {
#   type = string
# }

# variable "nodes_ingress_rules" {
#   type = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
# }

# variable "nodes_egress_rules" {
#   type = list(object({
#     from_port   = number
#     to_port     = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
# }

#IAM
variable "iam_name" {
  type    = string
  default = "demo-app"
}

variable "iam_policy_arns" {
  type    = set(string)
  default = []
}

