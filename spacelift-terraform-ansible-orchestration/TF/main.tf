terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1" # change if you prefer another region
}

# Latest Ubuntu 20.04 LTS (Canonical) in eu-west-1
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical
}

# Minimal, demo-only security group for SSH
resource "aws_security_group" "ssh_demo" {
  name        = "ssh-demo"
  description = "Allow SSH for Ansible demo"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr] # default 0.0.0.0/0; restrict to your IP for safety
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Use default VPC + a default subnet for public IPs (keeps demo simple)
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  instances = {
    instance1 = { ami = data.aws_ami.ubuntu.id, instance_type = "t2.micro" }
    instance2 = { ami = data.aws_ami.ubuntu.id, instance_type = "t2.micro" }
    instance3 = { ami = data.aws_ami.ubuntu.id, instance_type = "t2.micro" }
    instance4 = { ami = data.aws_ami.ubuntu.id, instance_type = "t2.micro" }
  }
}

# Register your Spacelift public key as an AWS key pair
resource "aws_key_pair" "ssh_key" {
  key_name   = "spacelift-demo-key"
  public_key = file(var.public_key) # /mnt/workspace/XT_spacelift_ansible.pub
}

resource "aws_instance" "this" {
  for_each      = local.instances
  ami           = each.value.ami
  instance_type = each.value.instance_type

  subnet_id                   = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [aws_security_group.ssh_demo.id]

  tags = {
    Name = each.key
  }
}
