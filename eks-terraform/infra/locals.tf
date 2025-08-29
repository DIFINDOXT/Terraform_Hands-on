# Why?
# Local values help name things consistently and tag resources.

locals {
  # We add a random suffix so repeated demos don’t collide
  cluster_name = "shubhxt-eks-${random_string.suffix.result}"

  common_tags = {
    project = "eks-terraform-demo"
    owner   = "shubhadeep"
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
