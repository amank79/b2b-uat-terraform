environment = "dev"

region = "ap-south-1"




#SG
# sg_name = "mbpro-sg"

# nodes_ingress_rules = [
#   {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   },
#   {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   },
#   {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# ]

# nodes_egress_rules = [
#   {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# ]

#IAM Role
iam_name        = "Demo-App-Role-New"
iam_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/AmazonEC2FullAccess","arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy","arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy","arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]

#Access Entries

access_entries = [
  {
    kubernetes_groups = []
    principal_arn     = "arn:aws:iam::905418245711:user/amankumar_aws"
    policy_associations = {
      example = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type       = "cluster"
        }
      }
    }
  }
]
