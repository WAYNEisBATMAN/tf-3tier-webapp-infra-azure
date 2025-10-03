#---------------------------------------------------
# Database Outputs
#---------------------------------------------------

# Azure SQL
output "sql_server_name" {
  description = "Azure SQL Server Name"
  value       = azurerm_mssql_server.sql_server.name
}

output "sql_database_name" {
  description = "Azure SQL Database Name"
  value       = azurerm_mssql_database.sql_db.name
}

# Azure MySQL
output "mysql_server_name" {
  description = "Azure MySQL Server Name"
  value       = var.db_type == "mysql" ? azurerm_mysql_server.mysql_server[0].name : ""
}

output "mysql_database_name" {
  description = "Azure MySQL Database Name"
  value       = var.db_type == "mysql" ? azurerm_mysql_database.mysql_db[0].name : ""
}

# Azure PostgreSQL
output "postgresql_server_name" {
  description = "Azure PostgreSQL Server Name"
  value       = var.db_type == "postgresql" ? azurerm_postgresql_server.postgresql_server[0].name : ""
}

output "postgresql_database_name" {
  description = "Azure PostgreSQL Database Name"
  value       = var.db_type == "postgresql" ? azurerm_postgresql_database.postgresql_db[0].name : ""
}

# Azure Cosmos DB
output "cosmosdb_account_name" {
  description = "Azure Cosmos DB Account Name"
  value       = azurerm_cosmosdb_account.cosmosdb.name
}

output "cosmosdb_database_name" {
  description = "Azure Cosmos DB Database Name"
  value       = azurerm_cosmosdb_sql_database.cosmosdb_db.name
}
