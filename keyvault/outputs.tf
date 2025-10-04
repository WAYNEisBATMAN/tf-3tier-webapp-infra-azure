output "keyvault_id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.main.id
}

output "keyvault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.main.vault_uri
}

output "admin_username" {
  description = "Admin username from Key Vault"
  value       = azurerm_key_vault_secret.admin_username.value
  sensitive   = true
}

output "admin_password" {
  description = "Admin password from Key Vault"
  value       = azurerm_key_vault_secret.admin_password.value
  sensitive   = true
}

output "sql_admin_password" {
  description = "SQL admin password from Key Vault"
  value       = azurerm_key_vault_secret.sql_admin_password.value
  sensitive   = true
}

output "db_admin_password" {
  description = "Database admin password from Key Vault"
  value       = azurerm_key_vault_secret.db_admin_password.value
  sensitive   = true
}