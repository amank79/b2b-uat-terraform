# Create IRSA for AWS Cluster Autoscaler
module "cluster_autoscaler_irsa_role" {
  source                                 = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                                = "5.42.0"
  role_name                              = "cluster-autoscaler-${var.environment}"
  attach_cluster_autoscaler_policy       = true
  oidc_providers = {
    eks-cluster = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
  tags = {
    Name = "ClusterAutoscalerIAMPolicy"
  }
}