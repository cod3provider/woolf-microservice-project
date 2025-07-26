# IAM-Role for EKS-cluster
resource "aws_iam_role" "eks" {
  # IAM-Role name for cluster EKS
  name = "${var.cluster_name}-eks-cluster"

  # Policy, which assume IAM-Role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# Attach IAM-Role to policy AmazonEKSClusterPolicy
resource "aws_iam_role_policy_attachment" "eks" {
  # ARN policy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # IAM-Role, for attaching policy
  role = aws_iam_role.eks.name
}

# Creating EKS-cluster
resource "aws_eks_cluster" "eks" {
  # Cluster name
  name     = var.cluster_name

  # ARN IAM-Role for managing of cluster
  role_arn = aws_iam_role.eks.arn

  # Network setup (VPC)
  vpc_config {
    endpoint_private_access = true   # Switch on private access to API-server
    endpoint_public_access  = true   # Switch on public access до API-server
    subnet_ids = var.subnet_ids      # List of subnets for EKS
  }

  # Access setup to EKS-cluster
  access_config {
    authentication_mode                         = "API"  # Authentication via API
    bootstrap_cluster_creator_admin_permissions = true   # Grants administrative rights to the user who created the cluster
  }

  # IAM policy dependency for EKS role
  depends_on = [aws_iam_role_policy_attachment.eks]
}
