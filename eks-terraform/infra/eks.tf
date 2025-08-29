# □ Why the EKS module?
# It wires control plane, node groups, security, OIDC, IRSA, etc., with sensible defaults.

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets  # control plane + nodes in private subnets
  enable_irsa     = true                        # OIDC for service accounts (IRSA)

  cluster_endpoint_public_access        = true
  cluster_endpoint_private_access       = true
  cluster_endpoint_public_access_cidrs  = ["223.185.129.225/32"]

  # Default settings for any node group defined below
  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t2.micro"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  # One node group for the demo; production often uses multiple (spot/on-demand mix)
  eks_managed_node_groups = {
    node_group = {
      min_size     = 2
      max_size     = 6
      desired_size = 3
    }
  }

  tags = merge(local.common_tags, {
    cluster = "demo"
  })
}

# ⚠️ IMPORTANT AUTOSCALING NOTE:
# Setting min/max/desired only defines capacity bounds.
# To scale "based on demand", you must deploy the Cluster Autoscaler
# (plus metrics server). We'll do that after the cluster is reachable.
