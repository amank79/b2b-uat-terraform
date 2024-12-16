module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.30"
  create_iam_role = true

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_additional_security_group_ids = ["${aws_security_group.control_plane_sg.id}"]
  access_entries                        = { for entry in var.access_entries : entry.principal_arn => entry }




  cluster_addons = {
    eks-pod-identity-agent = {}

  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

