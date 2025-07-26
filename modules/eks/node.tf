# IAM-Role for EC2-nodes (Worker Nodes)
resource "aws_iam_role" "nodes" {
  # Role name for nodes
  name = "${var.cluster_name}-eks-nodes"

  # Policy, which allows EC2 to assume the role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# Policy binding for EKS Worker Nodes
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

# Policy binding for Amazon VPC CNI plugin
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

# Policy binding for reading from Amazon ECR
resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

# Creating Node Group for EKS
resource "aws_eks_node_group" "general" {
  # Name EKS-cluster
  cluster_name = aws_eks_cluster.eks.name

  # Nodes group name
  node_group_name = "general"

  # IAM-role for nodes
  node_role_arn = aws_iam_role.nodes.arn

  # Subnets for EC2-nodes
  subnet_ids = var.subnet_ids

  # Type EC2-instances for nodes
  capacity_type  = "ON_DEMAND"
  instance_types = ["${var.instance_type}"]

  # Scaling configuration
  scaling_config {
    desired_size = var.desired_size  # Desired number of nodes
    max_size     = var.max_size      # Maximal numbers of nodes
    min_size     = var.min_size      # Minimal numbers of nodes
  }

  # Node update configuration
  update_config {
    max_unavailable = 1  # Maximum number of nodes that can be updated simultaneously
  }

  # Adds labels to nodes
  labels = {
    role = "general"  # Tag "role" with value "general"
  }

  # Dependencies for creating a Node Group
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  # Ignores changes to desired_size to avoid conflicts
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
