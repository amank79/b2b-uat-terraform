

#Environment
variable "environment" {
  type = string
}

#Region
variable "region" {
  type = string
}


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

variable "access_entries" {
  description = "List of access entries for the EKS cluster"
  type = list(object({
    kubernetes_groups = list(string)
    principal_arn     = string
    policy_associations = map(object({
      policy_arn = string
      access_scope = object({
        # namespaces = list(string)
        type = string
      })
    }))
  }))
  default = []
}
