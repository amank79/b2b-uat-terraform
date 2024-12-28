# Create IRSA for AWS Cluster Autoscaler
module "cluster_autoscaler_irsa_role" {
  source                                 = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                                = "5.42.0"
  role_name                              = "cluster-autoscaler-${var.environment}"
  attach_cluster_autoscaler_policy       = true
  cluster_autoscaler_cluster_names       = ["${module.eks.cluster_name}"]
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

#Cluster Autoscaler
resource "helm_release" "cluster-autoscaler" {
  depends_on = [module.cluster_autoscaler_irsa_role, aws_eks_node_group.eks_ng_private]
  name       = "aws-cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.43.2"
  namespace  = "kube-system"

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.cluster_autoscaler_irsa_role.iam_role_arn
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = module.eks.cluster_name
 }

}