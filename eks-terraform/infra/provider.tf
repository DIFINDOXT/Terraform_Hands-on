# Why?
# Tells Terraform which AWS account/region to talk to.
# Uses your existing local AWS CLI credentials (you already ran `aws configure`).

provider "aws" {
  region = var.aws_region
}

# Optional sanity checks (handy in interviews to show safety mindset)
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
