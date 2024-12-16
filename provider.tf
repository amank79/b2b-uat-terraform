terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}


# provider "http" {
# }

data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode("${data.aws_eks_cluster.eks_cluster.certificate_authority[0].data}")
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "${data.aws_eks_cluster.eks_cluster.id}"]
      command     = "aws"
    }
  }
}