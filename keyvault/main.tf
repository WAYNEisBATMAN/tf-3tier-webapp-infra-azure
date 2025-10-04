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
# Generate Random Passwords
#---------------------------------------------------
resource "random_password" "admin_password" {
  length  = 16
  special = true
}

resource "random_password" "sql_admin_password" {
  length  = 16
  special = true
}

resource "random_password" "db_admin_password" {
  length  = 16
  special = true
}

#---------------------------------------------------
# Store Generated Passwords in Key Vault
#---------------------------------------------------
resource "azurerm_key_vault_secret" "admin_password" {
  name         = "vm-admin-password"
  value        = random_password.admin_password.result
  key_vault_id = azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = random_password.sql_admin_password.result
  key_vault_id = azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "db_admin_password" {
  name         = "db-admin-password"
  value        = random_password.db_admin_password.result
  key_vault_id = azurerm_key_vault.main.id
}