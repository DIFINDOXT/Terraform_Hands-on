# Why this SG?
# Attach this SG to worker nodes so you can control their allowed traffic.

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "eks-worker-mgmt"
  })
}

# Ingress: allow from RFC1918 (your internal CIDRs)
# NOTE: tighten further in production (e.g., VPC CIDR only).
resource "aws_security_group_rule" "all_worker_mgmt_ingress" {
  description       = "allow inbound from private address ranges"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.all_worker_mgmt.id

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
}

# Egress: allow all (typical for nodes to pull images, reach APIs, etc.)
resource "aws_security_group_rule" "all_worker_mgmt_egress" {
  description       = "allow all outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.all_worker_mgmt.id
  cidr_blocks       = ["0.0.0.0/0"]
}
