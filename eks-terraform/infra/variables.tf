# Why?
# Inputs make your config reusable and interview-friendly.

variable "aws_region" {
  description = "AWS region for EKS and VPC"
  type        = string
  default     = "us-west-1"  # N. California (EKS is available here)
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "kubernetes_version" {
  description = "EKS control plane Kubernetes version"
  type        = string
  default     = "1.29"       # Use string to avoid float formatting issues
}
