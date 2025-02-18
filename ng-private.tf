# Create AWS EKS Node Group - Public
resource "aws_eks_node_group" "eks_ng_private" {
  depends_on   = [module.eks]
  cluster_name = "uat-eks-cluster"

  node_group_name = "${var.environment}-eks-ng-private"
  node_role_arn   = aws_iam_role.Demo-App-Role.arn
  subnet_ids      = module.vpc.private_subnets
  #version = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)    

  ami_type       = "AL2_x86_64"
  capacity_type  = "SPOT"
  disk_size      = 20
  instance_types = ["t3a.medium"]


  remote_access {
    ec2_ssh_key               = "mysql-key-pair"
    source_security_group_ids = ["${aws_security_group.ssh_sg.id}"]
  }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1
    #max_unavailable_percentage = 50    # ANY ONE TO USE
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  #   depends_on = [
  #     aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
  #     aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
  #     aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  #   ]

  tags = {
    Name = "Private-Node-Group"
  }
}
