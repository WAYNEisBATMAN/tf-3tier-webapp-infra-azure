# ☁️ Terraform-AWS—3‑Tier Web App Infrastructure Project

## 📌 Overview

This repository provides a complete Infrastructure as Code (IaC) solution for deploying a **3-tier web application** on Azure using Terraform. The modular architecture separates networking, compute, database, storage, monitoring, and security into independent, reusable components for enhanced maintainability and scalability.

---

## 🚀 What this Repo Provisions
- Network: Virtual Network (VNet), multiple subnets across availability zones, Network Security Groups (NSGs), NAT Gateway for secure outbound connectivity

- Compute: Linux Virtual Machines (Ubuntu 22.04 LTS) with public IPs, Azure Load Balancer for traffic distribution, Network Interface Cards (NICs) with security group associations

- Database: Azure SQL Database, Azure Database for MySQL Flexible Server, Cosmos DB for NoSQL workloads

- Storage: Azure Storage Account with Blob containers, File shares, Queue storage, and Table storage with lifecycle management

- Monitoring: Azure Monitor with Log Analytics Workspace, metric alerts for CPU usage, action groups for notifications

- Security: Azure Key Vault for secrets management with auto-generated passwords, SSH key pair generation for VM access

This setup implements a classic 3-tier architecture (presentation via Load Balancer + Web VMs, application tier on VMs, data tier on Azure SQL/MySQL/Cosmos DB).

---

## 📂 Project Structure

```
tf-3tier-webapp-infra-azure/
├── main.tf                  # Root-level module orchestration and resource group
├── variables.tf             # Root-level input variables
├── outputs.tf               # Root-level outputs
├── terraform.tfvars         # Variable values (exclude passwords)
│
├── network/
│   ├── main.tf              # VNet, subnets, NSG, NAT Gateway
│   ├── variables.tf
│   └── outputs.tf
│
├── compute/
│   ├── main.tf              # Linux VMs, Load Balancer, Public IPs, NICs
│   ├── variables.tf
│   └── outputs.tf
│
├── database/
│   ├── main.tf              # Azure SQL, MySQL Flexible Server, Cosmos DB
│   ├── variables.tf
│   └── outputs.tf
│
├── storage/
│   ├── main.tf              # Storage Account (Blob, File, Queue, Table)
│   ├── variables.tf
│   └── outputs.tf
│
├── monitoring/
│   ├── main.tf              # Log Analytics, Monitor Alerts, Action Groups
│   ├── variables.tf
│   └── outputs.tf
│
├── keyvault/
│   ├── main.tf              # Azure Key Vault, auto-generated passwords, secrets
│   ├── variables.tf
│   └── outputs.tf
│
└── ssh-keys/                # Auto-generated SSH key pairs (excluded from git)


```


---
## 🛠️ Prerequisites

### Required Software
- **Terraform** >= 1.12 ([Download](https://developer.hashicorp.com/terraform/downloads))
- **Azure CLI** >= 2.50.0 (Installation Guide)

### Azure Configuration
- Azure subscription with active account
- Azure CLI authenticated (az login)
- Appropriate permissions to create resources


### Required Azure Permissions
Your account must have permissions for:

- **Resource Groups:** Create, Read, Delete
- **Networking:** Virtual Networks, Subnets, NSGs, NAT Gateway, Public IPs
- **Compute:** Virtual Machines, Load Balancers, Network Interfaces
- **Database:** Azure SQL, MySQL Flexible Server, Cosmos DB
- **Storage:** Storage Accounts (Blob, File, Queue, Table)
- **Monitoring:** Log Analytics, Monitor Alerts, Action Groups
- **Security:** Key Vault (create, manage secrets)


### Optional Configuration
- Remote backend for state management (Azure Storage Account)
- Configure in backend.tf for state locking and team collaboration

---
## 🔑 Setting up Azure Credentials
Terraform uses Azure CLI authentication by default:

1. Install Azure CLI
```bash
   # For Ubuntu/Debian
   curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
   
   # For other OS, visit: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
```

2. Login to Azure
```bash
   az login
```
This opens a browser window for authentication.

3. Set Active Subscription (if you have multiple)
```bash
   # List subscriptions
   az account list --output table
   
   # Set active subscription
   az account set --subscription "YOUR_SUBSCRIPTION_ID"
```

4. Verify Authentication
```bash
   az account show
```
👉 Important:

Never hardcode credentials in Terraform files
Use environment variables for sensitive values
Add terraform.tfvars.secret and .env to .gitignore

---

## 🚀 Getting Started

1. **Clone the Repository**
   ```bash
   git clone https://github.com/WAYNEisBATMAN/tf-3tier-webapp-infra-azure.git
   cd tf-3tier-webapp-infra-azure
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

This command:
Downloads required provider plugins (AWS)
Initializes the backend for state storage
Prepares modules for use

3. **Validate Configuration**
   ```bash
   terraform validate
   ```

4. **Preview Changes**
   ```bash
   terraform plan
   ```

Review the planned changes carefully. Terraform will show:
Resources to be created
Estimated costs (if cost estimation is enabled)
Dependencies between resources

5. **Deploy Infrastructure**
   ```bash
   terraform apply
   ```

Type yes when prompted to confirm deployment.

Deployment Time: Approximately 10-15 minutes

---



## ♻️ Cleanup
terraform destroy from the root will attempt to delete all resources the modules created.

If state mismatches occur, consider terraform state rm for orphaned items before destroying.