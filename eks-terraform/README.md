# 🚀 EKS Cluster with Terraform (Hands-On Project)

This project provisions an **Amazon EKS cluster with worker nodes** using **Terraform**. 
It replicates a real-world organizational setup: 
- **VPC** with private/public subnets, NAT Gateway, route tables, NACLs, and security groups 
- **EKS cluster** with IRSA enabled 
- **Managed node group** (min=2, max=6) 
- **Secure IAM and SG configuration** 

---

## 📂 Project Structure
```
eks-terraform/
├── infra/ # Core Terraform files
│ ├── eks.tf
│ ├── vpc.tf
│ ├── securitygroups.tf
│ ├── versions.tf
│ ├── provider.tf
│ ├── locals.tf
│ ├── variables.tf
│ └── outputs.tf
├── extras/cluster-autoscaler/ # Optional production add-ons
│ ├── ca.yaml
│ ├── ca-policy.template.json
│ └── ca-trust.template.json
├── docs/screenshots/ # Screenshots of key steps
└── .gitignore
├── PROJECT_OVERVIEW.md
├── README.md ((Hi You Are Here))
├── challenges.md
```
---

## 🛠️ Steps Implemented

### 1. Core (Trainer Scope)
- Installed & validated Terraform + AWS CLI
- Used official Terraform modules:
  - [`terraform-aws-modules/vpc/aws`](https://github.com/terraform-aws-modules/terraform-aws-vpc)
  - [`terraform-aws-modules/eks/aws`](https://github.com/terraform-aws-modules/terraform-aws-eks)
- Broke down `.tf` files for readability
- Created:
  - VPC, subnets, NAT, NACLs, route tables
  - Security groups
  - EKS cluster
  - Node group (t3.medium, min=2, max=6)

📸 Screenshots:
- `terraform_init.png` 
- `terraform_plan.png` 
- `terraform_apply.png` 
- `subnets-vpc.png`, `route-tables-vpc.png`, `nat-gateway-vpc.png`, `security-groups-vpc.png`, `nacl-vpc.png`, `shubhxt-eks-vpc.png` 
- `eks-cluster.png` 
- `kubectl_get_nodes.png` / `kubectl get nodes -o wide-ui.png`

---

### 2. Enhancements (Optional)
Beyond trainer scope, implemented **extras for production-like setup**:

- **Metrics Server** add-on → Enabled resource monitoring 
  - Verified with `kubectl top nodes`
- **Cluster Autoscaler** 
  - IAM policy + IRSA role 
  - ServiceAccount & Deployment (`ca.yaml`) 
  - Learned troubleshooting (pod Pending due to memory limits) 
- **Errors/Troubleshooting captured**: 
  - `error-terraform_validate.png` 
  - `error-terraform_apply.png` 
  - `error-nodes.png`

---

## 📸 Screenshots (docs/screenshots/)

| Step                | Screenshot(s) |
|---------------------|---------------|
| Terraform init      | terraform_init.png |
| Terraform validate  | error-terraform_validate.png, success-terraform_validate.png |
| Terraform plan      | terraform_plan.png |
| Terraform apply     | error-terraform_apply.png |
| VPC resources       | shubhxt-eks-vpc.png, shubhxt-eks-vpc-tags.png, subnets-vpc.png, nat-gateway-vpc.png, route-tables-vpc.png, security-groups-vpc.png, nacl-vpc.png |
| EKS cluster (AWS UI)| eks-cluster.png |
| kubectl get nodes   | kubectl_get_nodes.png, kubectl get nodes -o wide-ui.png |
| Autoscaler errors   | error-nodes.png |
| Success proof       | Screenshot 2025-08-29 215756.png |

---

## ✅ Key Learnings
- Difference between Terraform syntax validation vs. runtime AWS API errors
- Importance of version compatibility (Terraform, AWS provider, Kubernetes version)
- IAM & RBAC integration: why root user needs explicit cluster access 
- How to enable monitoring (metrics-server) 
- Basics of Cluster Autoscaler, IRSA, and common scheduling issues 

---

## 🔒 Security Notes
- All account IDs, ARNs, and cluster endpoints are sanitized/blurred in screenshots.
- JSON IAM templates use placeholders (`${ACCOUNT_ID}`, `${CLUSTER_NAME}`, `${OIDC_HOSTPATH}`) for safety. 

---

## 📖 Credits
- Trainer: **Abhishek Veeramalla** 
- Video Link: https://youtu.be/_BTpd2oYafM?si=cEb-27OmTW78QrV4
- Extras, troubleshooting & documentation structured by me as part of DevOps learning journey. 
