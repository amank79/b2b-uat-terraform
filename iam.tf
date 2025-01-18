resource "aws_iam_role" "Demo-App-Role" {
  name = var.iam_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Name = "Demo-App-IAM-Role"
  }
}

resource "aws_iam_role_policy_attachment" "demo_app_policy" {
  for_each   = var.iam_policy_arns
  role       = aws_iam_role.Demo-App-Role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "demo_app-Instance-Profile" {
  name = var.iam_name
  role = aws_iam_role.Demo-App-Role.name
}


# Define the IAM Policy for the ALB Ingress Controller
resource "aws_iam_policy" "alb_ingress_controller" {
  name        = "AWSLoadBalancerControllerPolicy"
  description = "Policy for AWS Load Balancer Controller to interact with ALB"
  policy       = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:List*",
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:ModifyLoadBalancerAttributes",
          "elasticloadbalancing:DeleteLoadBalancer",
          "elasticloadbalancing:DeleteTargetGroup",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets",
          "iam:PassRole",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeInstances",
          "ec2:CreateSecurityGroup",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Define the IAM Policy for EKS Worker Node Permissions
resource "aws_iam_policy" "eks_worker_node" {
  name        = "AmazonEKSWorkerNodePolicy"
  description = "Policy for EKS Worker Nodes to interact with EKS and EC2"
  policy       = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeTags",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses",
          "ec2:ModifyNetworkInterfaceAttribute"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Define the IAM Policy for accessing ECR images
resource "aws_iam_policy" "ecr_read_only" {
  name        = "AmazonEC2ContainerRegistryReadOnly"
  description = "Policy for read-only access to Amazon ECR"
  policy       = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:GetImage"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach policies to the worker node role
resource "aws_iam_role_policy_attachment" "alb_ingress_policy_attachment" {
  policy_arn = aws_iam_policy.alb_ingress_controller.arn
  role       = aws_iam_role.eks_worker_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy_attachment" {
  policy_arn = aws_iam_policy.eks_worker_node.arn
  role       = aws_iam_role.eks_worker_node_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_read_only_policy_attachment" {
  policy_arn = aws_iam_policy.ecr_read_only.arn
  role       = aws_iam_role.eks_worker_node_role.name
}

# Define the IAM Role for the EKS Worker Nodes
resource "aws_iam_role" "eks_worker_node_role" {
  name               = "eks-worker-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "eks-worker-node-external-id"
          }
        }
      }
    ]
  })
}
