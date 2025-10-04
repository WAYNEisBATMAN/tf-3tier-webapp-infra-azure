#---------------------------------------------------
# Root Module - Azure 3-Tier Web App Infra
#---------------------------------------------------

#---------------------------------------------------
# Resource Group
#---------------------------------------------------
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "TestProject"
    ManagedBy   = "Terraform"
    Project     = "3-Tier-WebApp"
  }
}

#---------------------------------------------------
# Key Vault Module (Create first)
#---------------------------------------------------
module "keyvault" {
  source = "./keyvault"

  keyvault_name       = var.keyvault_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  admin_username      = var.admin_username
  # Passwords are now generated automatically - no need to pass them

  depends_on = [azurerm_resource_group.main]
}


#---------------------------------------------------
# Network Module
#---------------------------------------------------
module "network" {
  source              = "./network"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  depends_on          = [azurerm_resource_group.main]
}

#---------------------------------------------------
# Compute Module
#---------------------------------------------------
module "compute" {
  source              = "./compute"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  admin_username      = module.keyvault.admin_username
  admin_password      = module.keyvault.admin_password
  nsg_id              = module.network.nsg_id
  subnet_ids          = module.network.subnet_ids

  depends_on = [
    azurerm_resource_group.main,
    module.network,
    module.keyvault
  ]
}

#---------------------------------------------------
# Database Module
#---------------------------------------------------
module "database" {
  source                 = "./database"
  location               = var.location
  resource_group_name    = azurerm_resource_group.main.name
  cosmosdb_database_name = var.cosmosdb_database_name
  db_server_name         = var.db_server_name
  sql_admin_username     = var.sql_admin_username
  sql_admin_password     = module.keyvault.sql_admin_password
  db_admin_username      = var.db_admin_username
  db_admin_password      = module.keyvault.db_admin_password
  db_name                = var.db_name
  cosmosdb_account_name  = var.cosmosdb_account_name
  subnet_ids             = module.network.subnet_ids

  depends_on = [
    azurerm_resource_group.main,
    module.network,
    module.keyvault
  ]
}

#---------------------------------------------------
# Random Suffix for Storage Account Name
#---------------------------------------------------
resource "random_string" "storage_suffix" {
  length  = 8
  special = false
  upper   = false
}

#---------------------------------------------------
# Storage Module
#---------------------------------------------------
module "storage" {
  source               = "./storage"
  location             = var.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_name = "tfstore${random_string.storage_suffix.result}"

  depends_on = [azurerm_resource_group.main]
}

#---------------------------------------------------
# Monitoring Module
#---------------------------------------------------
module "monitoring" {
  source              = "./monitoring"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  vm_ids              = module.compute.vm_ids
  alert_email         = var.alert_email

  depends_on = [
    azurerm_resource_group.main,
    module.compute
  ]
}







