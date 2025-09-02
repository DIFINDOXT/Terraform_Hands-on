variable "public_key" {
  description = "Path to the public key file mounted by Spacelift Context"
  type        = string
  default     = "/mnt/workspace/XT_spacelift_ansible.pub"
}

variable "ssh_ingress_cidr" {
  description = "Who can SSH for the demo (restrict to your IP in real use)"
  type        = string
  default     = "0.0.0.0/0"
}
