module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.31"

enable_irsa = true

  bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }


  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets


  eks_managed_node_groups = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "ami-0614680123427b75e"
      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 10
      desired_size = 2
    
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}