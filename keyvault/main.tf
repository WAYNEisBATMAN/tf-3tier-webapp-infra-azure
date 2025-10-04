#---------------------------------------------------
# Get current Azure client configuration
#---------------------------------------------------
data "azurerm_client_config" "current" {}

#---------------------------------------------------
# Azure Key Vault
#---------------------------------------------------
resource "azurerm_key_vault" "main" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover"
    ]
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

#---------------------------------------------------
# Store Admin Username
#---------------------------------------------------
resource "azurerm_key_vault_secret" "admin_username" {
  name         = "vm-admin-username"
  value        = var.admin_username
  key_vault_id = azurerm_key_vault.main.id
}

#---------------------------------------------------
# Store Admin Password
#---------------------------------------------------
resource "azurerm_key_vault_secret" "admin_password" {
  name         = "vm-admin-password"
  value        = var.admin_password
  key_vault_id = azurerm_key_vault.main.id
}

#---------------------------------------------------
# Store SQL Admin Password
#---------------------------------------------------
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = var.sql_admin_password
  key_vault_id = azurerm_key_vault.main.id
}

#---------------------------------------------------
# Store Database Admin Password
#---------------------------------------------------
resource "azurerm_key_vault_secret" "db_admin_password" {
  name         = "db-admin-password"
  value        = var.db_admin_password
  key_vault_id = azurerm_key_vault.main.id
}