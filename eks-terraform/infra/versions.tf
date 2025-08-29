# Why this file?
# Locks Terraform core & provider versions so your build is reproducible and compatible
# The EKS module v20.x expects modern versions (Terraform ≥1.3, AWS provider ≥5.x).

terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40.0, < 6.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.7.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.2.0"
    }
  }
}
