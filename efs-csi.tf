# # Resource: EFS CSI Driver AddOn
# # Install EFS CSI Driver using EKS Add-Ons
# resource "aws_eks_addon" "efs_eks_addon" {
#   depends_on               = [module.efs_csi_irsa_role, aws_eks_node_group.eks_ng_private]
#   cluster_name             = module.eks.cluster_name
#   addon_version            = "v1.5.0-eksbuild.1"
#   addon_name               = "aws-efs-csi-driver"
#   service_account_role_arn = module.efs_csi_irsa_role.iam_role_arn
# }

# # Create IRSA for EFS CSI Driver using Terraform Modules
# module "efs_csi_irsa_role" {
#   source                = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   version               = "5.48.0"
#   role_name             = "efs-csi-eks-role-${var.environment}"
#   attach_efs_csi_policy = true
#   oidc_providers = {
#     eks-cluster = {
#       provider_arn             = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:efs-csi-controller-sa"]
#     }
#   }
#   tags = {
#     tag-key = "AWSEFSCSIControllerIAMPolicy"
#   }
# }