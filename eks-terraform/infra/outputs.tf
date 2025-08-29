output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "EKS control plane endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Cluster control plane security group ID"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  value       = module.eks.oidc_provider_arn
}

# Handy copy-paste helper:
output "update_kubeconfig" {
 description = "Command to merge kubeconfig for this cluster"
  value       = format(
    "aws eks update-kubeconfig --name %s --region %s",
    local.cluster_name,  // use our known name instead of a null module output
    var.aws_region
  )
}
