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
    Project     = "3-Tier-WebApp  "
  }
}


module "network" {
  source              = "./network"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "compute" {
  source              = "./compute"
  location            = var.location
  resource_group_name = var.resource_group_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  nsg_id              = module.network.nsg_id
  subnet_ids          = module.network.subnet_ids
}

module "database" {
  source                 = "./database"
  location               = var.location
  resource_group_name    = var.resource_group_name
  cosmosdb_database_name = var.cosmosdb_database_name
  db_server_name         = var.db_server_name
  sql_admin_password     = var.sql_admin_password
  db_admin_password      = var.db_admin_password
  db_admin_username      = var.db_admin_username
  sql_admin_username     = var.sql_admin_username
  db_name                = var.db_name
  cosmosdb_account_name  = var.cosmosdb_account_name
  subnet_ids             = var.subnet_ids
}


resource "random_string" "storage_suffix" {
  length  = 8
  special = false
  upper   = false
}




module "storage" {
  source               = "./storage"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_name = "tfstore${random_string.storage_suffix.result}"
}

module "monitoring" {
  source              = "./monitoring"
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_ids              = module.compute.vm_ids
  alert_email         = var.alert_email
}
