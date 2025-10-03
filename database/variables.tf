#---------------------------------------------------
# Database Module Variables
#---------------------------------------------------

variable "subnet_ids" {
  description = "List of subnet IDs for delegated subnet assignment"
  type        = list(string)
  default = []
}

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
