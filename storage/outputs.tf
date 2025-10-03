#---------------------------------------------------
# Storage Outputs
#---------------------------------------------------

output "storage_account_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.storage.name
}

output "blob_container_name" {
  description = "Name of Blob container if enabled"
  value       = var.enable_blob_service ? azurerm_storage_container.blob[0].name : ""
}

output "file_share_name" {
  description = "Name of File share if enabled"
  value       = var.enable_file_service ? azurerm_storage_share.file_share[0].name : ""
}

output "queue_name" {
  description = "Name of Queue if enabled"
  value       = var.enable_queue_service ? azurerm_storage_queue.queue[0].name : ""
}

output "table_name" {
  description = "Name of Table if enabled"
  value       = var.enable_table_service ? azurerm_storage_table.table[0].name : ""
}
