#----------------------------------------------------------------------------
# Root Module
#----------------------------------------------------------------------------
variable "azure_location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "South India"  # Equivalent to ap-south-1
}

#----------------------------------------------------------------------------
# Compute Module
#----------------------------------------------------------------------------
#---------------------------------------------------
# Compute Module Variables
#---------------------------------------------------

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region to deploy compute resources"
  type        = string
  default     = "Central India"
}

variable "instance_count" {
  description = "Number of VMs to deploy"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VMs"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs to deploy VMs"
  type        = list(string)
}

variable "nsg_id" {
  description = "Network Security Group ID to attach to VMs"
  type        = string
}


#----------------------------------------------------------------------------
# Network Module
#----------------------------------------------------------------------------
variable "vnet_cidr" {
  description = "VNet CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets to create in the VNet"
  type        = number
  default     = 2
}

#----------------------------------------------------------------------------
# Storage Module
#----------------------------------------------------------------------------
variable "storage_account_name" {
  description = "Azure Storage Account name (globally unique)"
  type        = string
  default     = "myterraformappsa12345"
}

variable "storage_container_name" {
  description = "Name of the container inside the storage account"
  type        = string
  default     = "app-container"
}




#---------------------------------------------------
# Database Module Variables
#---------------------------------------------------

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region to deploy database resources"
  type        = string
  default     = "Central India"
}

# Azure SQL Database
variable "sql_server_name" {
  description = "Name of the Azure SQL Server"
  type        = string
  default     = "terraform-sql-server-12345"
}

variable "sql_db_name" {
  description = "Name of the Azure SQL Database"
  type        = string
  default     = "terraform-sql-db"
}

variable "sql_admin_username" {
  description = "SQL Server admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server admin password"
  type        = string
}

# Azure Database for MySQL/PostgreSQL
variable "db_server_name" {
  description = "Name of the MySQL/PostgreSQL server"
  type        = string
}

variable "db_type" {
  description = "Database type (mysql or postgresql)"
  type        = string
  default     = "mysql"
}

variable "db_name" {
  description = "Name of the MySQL/PostgreSQL database"
  type        = string
}

variable "db_admin_username" {
  description = "Database admin username"
  type        = string
}

variable "db_admin_password" {
  description = "Database admin password"
  type        = string
}

# Cosmos DB
variable "cosmosdb_account_name" {
  description = "Azure Cosmos DB account name"
  type        = string
}

variable "cosmosdb_kind" {
  description = "Cosmos DB API kind (e.g., MongoDB, GlobalDocumentDB, Cassandra, Gremlin)"
  type        = string
  default     = "GlobalDocumentDB"
}

variable "cosmosdb_database_name" {
  description = "Cosmos DB database name"
  type        = string
}


#---------------------------------------------------
# Monitoring Module Variables
#---------------------------------------------------

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources"
  type        = string
  default     = "Central India"
}

variable "vm_ids" {
  description = "List of VM IDs to monitor"
  type        = list(string)
}

variable "alert_email" {
  description = "Email address to send alerts to"
  type        = string
}