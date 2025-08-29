# Why a module?
# The official VPC module encodes best practices and saves time.

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name   = "shubhxt-eks-vpc"
  cidr   = var.vpc_cidr
  # Using the first two AZs keeps it simple and cheap
  azs              = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets   = ["10.0.4.0/24", "10.0.5.0/24"]

  enable_nat_gateway   = true    # Private subnets need outbound internet through NAT
  single_nat_gateway   = true    # Cost optimization: one NAT GW for both private subnets
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  })

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"  # Let ELB pick public subnets
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"  # Internal LBs go here
  }
}
