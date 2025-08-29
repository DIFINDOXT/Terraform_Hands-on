# 🚀 EKS Cluster with Terraform – Project Overview

This project provisions an **EKS cluster on AWS using Terraform** with autoscaling-enabled node groups, security groups, and optional production-style add-ons (Cluster Autoscaler).  
Screenshots are linked inline for each major step.

---

## 1️⃣ Project Initialization

- Wrote core Terraform files (`provider.tf`, `versions.tf`, `vpc.tf`, `eks.tf`, `securitygroups.tf`, `outputs.tf`, `variables.tf`, `locals.tf`).
- Initialized Terraform and downloaded required AWS & Kubernetes providers.

📸 [Terraform Init](/docs/screenshots/init.png)

---

## 2️⃣ Syntax Validation

- Ensured Terraform code is valid and supported.
- Fixed provider version mismatches & updated `versions.tf`.

📸 [Terraform Validate](/docs/screenshots/validate.png)

---

## 3️⃣ Infrastructure Planning

- Ran `terraform plan` to preview resources.
- Verified creation of **VPC, Subnets, Security Groups, EKS Cluster, Node Groups**.
- Plan showed ~55 resources to be created.

📸 [Terraform Plan](docs/screenshots/plan.png)

---

## 4️⃣ Apply & Cluster Creation

- Applied the plan with `terraform apply`.
- Waited ~10–12 minutes for EKS cluster + managed node group (2 min, 6 max) to be created.

📸 [Terraform Apply](/docs/screenshots/apply.png)

---

## 5️⃣ kubeconfig Update

- Updated local kubeconfig to connect `kubectl` with the new EKS cluster.

📸 [Update Kubeconfig](/docs/screenshots/update-kubeconfig.png)

---

## 6️⃣ Cluster Verification

- Verified cluster connection with `kubectl get nodes`.
- Saw 2 nodes registered (t3.medium) with desired capacity.

📸 [Get Nodes](/docs/screenshots/get-nodes.png)

---
# 🚀 EKS Cluster with Terraform – Project Overview (Part 2/3)

---

## 7️⃣ VPC & Networking Verification

After `terraform apply`, verified all networking resources:

- VPC created with proper tags (`kubernetes.io/cluster/...=shared`)
- 2 private + 2 public subnets
- Single NAT Gateway
- Route tables, NACLs, and Security Groups

📸 [VPC](/docs/screenshots/shubhxt-eks-vpc.png)
📸 [VPC Tags](/docs/screenshots/shubhxt-eks-vpc-tags.png) 
📸 [Subnets](/docs/screenshots/subnets-vpc.png) 
📸 [NAT Gateway](/docs/screenshots/nat-gateway-vpc.png) 
📸 [Route Tables](/docs/screenshots/route-tables-vpc.png) 
📸 [Security Groups](/docs/screenshots/security-groups-vpc.png) 
📸 [NACL](/docs/screenshots/nacl-vpc.png)

---

## 8️⃣ Metrics Server Add-on

- Installed **EKS metrics-server** add-on from AWS.
- Verified with `kubectl top nodes`.

📸 [Metrics Server Active](/docs/screenshots/metrics-server.png) 
📸 [kubectl top nodes](/docs/screenshots/kubectl-top-nodes.png)

---

## 9️⃣ Cluster Autoscaler Setup (Optional Enhancement)

- Created IAM Policy (`EKS-ClusterAutoscaler-Policy`) 
- Created IAM Role (`EKS-ClusterAutoscaler-Role`) with OIDC trust 
- Applied `ca.yaml` to deploy the Cluster Autoscaler pod

📸 [Autoscaler IAM Policy](/docs/screenshots/ca-policy.png)
📸 [Autoscaler IAM Role](/docs/screenshots/ca-trust.png)
📸 [Autoscaler Deployment](/docs/screenshots/ca-deploy.png)

---

## 🔧 Autoscaler Troubleshooting

- Pod initially stayed in `Pending` due to:
  - Insufficient node memory
  - Too many pods per node
- Fixed by scaling node group desired size and re-checking logs.

📸 [Autoscaler Pending](../docs/screenshots/ca-pending.png) 
📸 [Autoscaler Logs](../docs/screenshots/ca-logs.png)

---

## 🔄 1️⃣ Cleanup & Cost Management

To avoid ongoing AWS billing:

## 1. Deleted Cluster Autoscaler deployment:
```
kubectl delete -f ca.yaml
```
## 2.Removed metrics-server add-on:
```
aws eks delete-addon \
  --cluster-name <cluster_name> \
  --addon-name metrics-server \
  --region <region>
```
## 3. Destroyed all Terraform-managed resources:
```
terraform destroy -auto-approve
```
📸 Terraform Destroy


**Verified IAM policies/roles manually cleaned up in AWS console.**

---

## 📝 2️⃣ Key Learningss

- Terraform idempotency:
Plan vs. Apply vs. Destroy and how Terraform resumes where it left off.

- Validation vs. runtime errors:
Syntax passed validation, but apply failed due to unsupported Kubernetes version → highlights importance of checking AWS release notes.

- Networking clarity:
Understood how VPC, Subnets, Route Tables, NAT, and Tags integrate with EKS.

- RBAC & IAM integration:
Root user still needs explicit access entry → importance of RBAC with IAM roles.

- Monitoring & scaling:

	- Metrics server enables kubectl top
	- Cluster Autoscaler requires IAM + OIDC + tuning node group resources.

- Troubleshooting skills:
Interpreted pod Pending events, checked logs, and fixed scheduling issues.

--- 

## 🙌 3️⃣ Credits
- Trainer: Abhishek Veeramalla → EKS core infra module walkthrough.
- Enhancements & Documentation: My own add-ons:
	- Metrics server
	- Cluster Autoscaler
	- Structured repo with infra/, extras/, docs/screenshots/
	- Step-by-step docs (PROJECT_OVERVIEW.md)

---
