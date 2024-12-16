# Resource: EBS CSI Driver AddOn
# Install EBS CSI Driver using EKS Add-Ons
resource "aws_eks_addon" "ebs_eks_addon" {
  # depends_on               = [aws_iam_role_policy_attachment.ebs_csi_iam_role_policy_attach, aws_eks_node_group.eks_ng_private]
  depends_on               = [module.ebs_csi_irsa_role, aws_eks_node_group.eks_ng_private, ]
  cluster_name             = module.eks.cluster_name
  addon_version            = "v1.32.0-eksbuild.1"
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
}

# Create IRSA for EBS CSI Driver using Terraform Modules
module "ebs_csi_irsa_role" {
  source                = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version               = "5.42.0"
  role_name             = "ebs-csi-eks-role-${var.environment}"
  attach_ebs_csi_policy = true
  oidc_providers = {
    eks-cluster = {
      principal_arn              = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
  tags = {
    tag-key = "AWSEBSCSIControllerIAMPolicy"
  }
}