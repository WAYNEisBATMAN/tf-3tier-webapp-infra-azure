# ☁️ Terraform-Azure-3-Tier Web App Infrastructure Project

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
👉 **Important:**

- Never hardcode credentials in Terraform files
- Use environment variables for sensitive values
- Add terraform.tfvars.secret and .env to .gitignore

---

## 🚀 Getting Started

1. **Clone the Repository**
   ```bash
   git clone https://github.com/WAYNEisBATMAN/tf-3tier-webapp-infra-azure.git
   cd tf-3tier-webapp-infra-azure
   ```

2. **Configure Variables**
Edit terraform.tfvars:

terraform
resource_group_name = "my-3tier-rg"
location            = "southindia"
vnet_name           = "my-vnet"
address_space       = ["10.0.0.0/16"]
subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
instance_count      = 2
vm_size             = "Standard_B1s"
admin_username      = "azureadmin"
keyvault_name       = "my3tierkv12345"  # Must be globally unique
Set sensitive values via environment variables:

```bash
export TF_VAR_alert_email="your-email@example.com"
```
Passwords are auto-generated by the Key Vault module.

3. **Create SSH Keys Directory**
```bash
mkdir -p ssh-keys
```

4. Initialize Terraform
```bash
terraform init
```
This command:
Downloads required provider plugins (Azure, Random, TLS, Local)
Initializes backend for state storage
Prepares modules for use

5. Validate Configuration
```bash
terraform validate
```

6. Preview Changes
```bash
terraform plan
```

Review the planned changes. Terraform will show:

30+ resources to be created
Resource dependencies
Module execution order

7. Deploy Infrastructure
```bash
terraform apply -auto-approve
```

Deployment Time: Approximately 8-12 minutes

---



## ♻️ Cleanup
terraform destroy from the root will attempt to delete all resources the modules created.

If state mismatches occur, consider terraform state rm for orphaned items before destroying.