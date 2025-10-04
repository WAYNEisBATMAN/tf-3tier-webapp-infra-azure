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
- Edit terraform.tfvars as per your requirements.
- Set sensitive values via environment variables:

```bash
export TF_VAR_alert_email="your-email@example.com"
```
Passwords are auto-generated by the Key Vault module.

3. **Create SSH Keys Directory**
```bash
mkdir -p ssh-keys
```

4. **Initialize Terraform**
```bash
terraform init
```
This command:
Downloads required provider plugins (Azure, Random, TLS, Local)
Initializes backend for state storage
Prepares modules for use

5. **Validate Configuration**
```bash
terraform validate
```

6. **Preview Changes**
```bash
terraform plan
```

Review the planned changes. Terraform will show:

30+ resources to be created
Resource dependencies
Module execution order

7. **Deploy Infrastructure**
```bash
terraform apply -auto-approve
```

Deployment Time: Approximately 8-12 minutes

*What gets created:*

- 1 Resource Group
- 1 Virtual Network with 2 subnets
- 1 Network Security Group
- 1 NAT Gateway
- 2 Linux Virtual Machines (Ubuntu 22.04)
- 1 Load Balancer with public IP
- 3 Database services (SQL, MySQL, Cosmos DB)
- 1 Storage Account with containers
- 1 Log Analytics Workspace
- 1 Key Vault with auto-generated passwords
- 1 SSH key pair

8. **Access Outputs**
```bash
# View all outputs
terraform output

# View specific output
terraform output vm_public_ips
terraform output application_url
terraform output ssh_connection_commands
```



9. **SSH into VMs**
```bash
# Get SSH commands
terraform output ssh_connection_commands

# Connect to VM
ssh -i ssh-keys/terraform-vm-key.pem azureadmin@<VM_PUBLIC_IP>
```

---

## 🔐 Security Features
**Auto-Generated Credentials**
- VM passwords: Auto-generated 16-character passwords stored in Key Vault
- SQL passwords: Auto-generated and stored securely
- MySQL passwords: Auto-generated and stored securely
- SSH keys: 4096-bit RSA key pairs generated automatically

**Retrieve Passwords**
```bash
# Via Azure CLI
az keyvault secret show --vault-name "my3tierkv12345" --name "vm-admin-password" --query "value" -o tsv

# Via Azure Portal
Azure Portal → Key Vaults → my3tierkv12345 → Secrets
```

**Network Security**
- NSG rules allow only HTTP (80) and SSH (22)
- NAT Gateway for secure outbound connectivity
- Private IPs for internal communication
- Public IPs only for Load Balancer and VMs (can be removed for production)

---
## 📝 Important Notes
- Costs: Running this infrastructure incurs Azure charges. Monitor your Azure Cost Management.
- State File: Contains sensitive information. Never commit terraform.tfstate to git.
- Key Vault Names: Must be globally unique (3-24 characters, alphanumeric).
- Storage Account Names: Must be globally unique (3-24 characters, lowercase alphanumeric).
- VM Passwords: Auto-generated passwords meet Azure complexity requirements.
- SSH Keys: Stored in ssh-keys/ directory (added to .gitignore).



---
## 🐛 Troubleshooting
**Issue: Resource Group already exists**
```bash
# Import existing resource group
terraform import azurerm_resource_group.main /subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP_NAME
```

**Issue: Key Vault name already taken**
- Change keyvault_name in terraform.tfvars to a unique value.

**Issue: Cannot SSH to VMs**
- Check NSG rules allow port 22
- Verify public IP is assigned
- Check SSH key permissions: chmod 600 ssh-keys/terraform-vm-key.pem

**Issue: Terraform state locked**
```bash
# Force unlock (use carefully)
terraform force-unlock LOCK_ID
```

---
📊 Monitoring
**Available Metrics**
- CPU usage alerts (threshold: 80%)
- Log Analytics Workspace for centralized logging
- Action Groups for email notifications

**View Metrics**
```bash
# Azure Portal
Azure Portal → Monitor → Metrics

# Azure CLI
az monitor metrics list --resource <RESOURCE_ID>
```

---
## 🔄 Updating Infrastructure
**Modify terraform.tfvars or module files**
- Preview changes
```bash
terraform plan
```

- Apply changes
```bash
terraform apply
```

---
## 🗑️ Cleanup
- Destroy all resources:
```bash
terraform destroy -auto-approve
```

- Destroy specific module:
```bash
terraform destroy -target=module.compute
```

*⚠️ Warning: This permanently deletes all resources including:*

- Virtual Machines and data
- Databases (SQL, MySQL, Cosmos DB)
- Storage accounts and data
- Key Vault (with soft-delete enabled, can be recovered for 7 days)
- Cleanup Time: Approximately 5-8 minutes