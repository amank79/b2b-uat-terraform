module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.30"
  create_iam_role = true

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_additional_security_group_ids = ["${aws_security_group.node_sg.id}"]




  cluster_addons = {
    eks-pod-identity-agent = {}

  }
#  eks_managed_node_group_defaults = {
#     ami_type               = "AL2023_x86_64_STANDARD"
#     instance_types         = ["t2.micro"]
#     vpc_security_group_ids = [aws_security_group.node_sg.id]
#   }

#   eks_managed_node_groups = {

#     node_group = {
#       min_size     = 2
#       max_size     = 6
#       desired_size = 2
#     }
#   }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets





  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}