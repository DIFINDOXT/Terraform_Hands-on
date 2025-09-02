# Spacelift + Terraform + Ansible Orchestration

End-to-end demo that provisions EC2 instances with **Terraform** and configures them with **Ansible**, orchestrated by **Spacelift**.

## Structure
- `TF/` – Terraform code (EC2 + outputs for Ansible)
- `ansible/` – Playbooks, inventory hook logic
- `.github/workflows/` – (optional) CI later
- `docs/` – Notes and screenshots

## High-Level Flow
Terraform → (Spacelift passes EC2 IPs) → Ansible installs `htop`.

> Next: add Terraform boilerplate, then wire up Spacelift stacks.
