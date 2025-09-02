# 🌍 Terraform Projects – Infrastructure as Code (IaC)

This folder showcases my **Terraform hands-on practice and projects**, as part of my DevOps transition journey.  
It contains multiple **subprojects**, each focused on provisioning and managing cloud infrastructure in a modular, production-ready way.

---

## 📂 What’s Inside

Each subfolder = one Terraform project.  
Each project includes:  
- ✅ `main.tf`, `variables.tf`, `outputs.tf` (core IaC definitions)  
- ✅ `docs/` with project overview & architecture notes  
- ✅ `screenshots/` with real `terraform plan/apply` outputs  
- ✅ `challenges.md` documenting errors & how I solved them  

---

## 🚀 Projects Covered

| Project | Cloud/Infra Focus | Tools/Concepts |
|---------|------------------|----------------|
| `eks-cluster/` | EKS cluster provisioning on AWS | VPC, Subnets, NAT Gateway, EKS, Security Groups |
| `spacelift-pipeline/` | Orchestration of Terraform + Ansible workflows | Spacelift, Terraform, Ansible |
| *(more coming...)* | EC2, S3, IAM, Monitoring | Terraform modules, remote state, workspaces |

---

## 🛠️ Skills Demonstrated

- Infrastructure as Code (IaC) best practices  
- Modular Terraform design  
- VPC networking (subnets, route tables, NAT, IGW)  
- Kubernetes cluster provisioning on AWS (EKS)  
- State management, validation, and plan/apply workflows  
- Debugging & handling Terraform errors (`terraform validate`, `terraform plan`)  

---

## 📸 Example Screenshot

Terraform Plan Example:

![Terraform Plan](./eks-cluster/docs/screenshots/terraform_plan.png)

---

## 📖 How to Navigate

- Go into each subproject (e.g., `eks-cluster/`) to view code + docs.  
- Each project folder has its own **README.md** explaining architecture, commands, and challenges.  

---

💡 **Note:** This repo is for **Terraform-only focus**. If you want to see **end-to-end DevOps projects** (IaC + CI/CD + monitoring), check my main GitHub account projects.
