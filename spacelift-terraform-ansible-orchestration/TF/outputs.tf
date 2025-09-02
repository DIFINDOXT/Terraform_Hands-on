# A simple list of public IPs for Ansible to consume
output "aws_instances" {
  description = "Public IPs of all EC2 instances"
  value       = [for i in aws_instance.this : i.public_ip]
}
