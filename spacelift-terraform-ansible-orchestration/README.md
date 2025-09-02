# Spacelift + Terraform + Ansible Orchestration

This project demonstrates **Infrastructure as Code (Terraform)** combined with **Configuration Management (Ansible)** triggered via **Spacelift pipelines**.

---

## 📑 What This Does
- Provisions AWS EC2 instances (t2.micro) using Terraform.
- Configures the instances with Ansible:
  - Installs **Nginx**
  - Deploys a custom `index.html`
  - Ensures service is enabled and running.
- Executes via Spacelift CI/CD pipeline with custom hooks.

---

## 📂 Repo Structure
```
├── README.md
├── TF
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── ansible
│   ├── install_htop.yml
│   └── install_nginx.yml
├── docs
│   ├── PROJECT_OVERVIEW.md
│   ├── challenges.md
│   └── screenshots
│       
└── terraform.tfstate
```
---

## ⚡ Key Learnings
- **Terraform + Ansible integration** is powerful but requires careful inventory sync.
- **Spacelift check mode** may show false negatives for service states; Apply is more reliable.
- **Manual validation** via SSH is an important safety net.
- Even partial automation adds credibility in interviews: shows ability to debug, integrate multiple tools, and document challenges transparently.

---

## 📑 Documentation

- Project Overview → Full story of the build, step-by-step.
- Challenges → Errors, debugging, lessons learned.
- Docs/→ Screenshots of Spacelift runs, error logs, EC2 console, etc.

---

## ✅ Validation
After retries and manual intervention:
- Nginx was successfully installed (`dpkg -l | grep nginx`).
- Service confirmed via `systemctl status nginx`.
- Web page accessible with `curl -I http://<public_ip>`.

---

## 🙌 Credits & References

- Abhishek Veeramalla → For demo guidance and inspiration. - [ https://youtu.be/DQUUi87AEtM?si=UIS9aRiic69LFSFv ]
- Spacelift Blog → Orchestrating Terraform with Ansible - [ https://spacelift.io/blog/using-terraform-and-ansible-together ]

---

## 🏷️ Tags
`Terraform` · `Ansible` · `Spacelift` · `AWS` · `CI/CD` · `DevOps Practice`
