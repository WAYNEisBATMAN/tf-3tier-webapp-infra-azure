#---------------------------------------------------
# Azure SQL Server & Database
#---------------------------------------------------
resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "sql_db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "S0"
}

#---------------------------------------------------
# Azure Database for MySQL Flexible Server
#---------------------------------------------------
resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  count                  = var.db_type == "mysql" ? 1 : 0
  name                   = var.db_server_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password

  sku_name = "B_Standard_B1ms" # Flexible Server SKU (Basic tier)

  version = "8.0.21"

  tags = {
    Environment = "Terraform"
  }
}


resource "azurerm_mysql_flexible_database" "mysql_db" {
  count               = var.db_type == "mysql" ? 1 : 0
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server[0].name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}

resource "azurerm_postgresql_server" "postgresql_server" {
  count                         = var.db_type == "postgresql" ? 1 : 0
  name                          = var.db_server_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  administrator_login           = var.db_admin_username
  administrator_login_password  = var.db_admin_password
  sku_name                      = "B_Gen5_1"
  version                       = "10.0"
  storage_mb                    = 5120
  backup_retention_days         = 7
  ssl_enforcement_enabled       = true
  public_network_access_enabled = true
}

resource "azurerm_postgresql_database" "postgresql_db" {
  count               = var.db_type == "postgresql" ? 1 : 0
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql_server[0].name
  charset             = "UTF8"
  collation           = "en_US.utf8"
}

#---------------------------------------------------
# Azure Cosmos DB
#---------------------------------------------------
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = var.cosmosdb_kind
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb_db" {
  name                = var.cosmosdb_database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
}
