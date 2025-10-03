#---------------------------------------------------
# Azure Storage Account
#---------------------------------------------------
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

#---------------------------------------------------
# Enable Blob Service
#---------------------------------------------------
resource "azurerm_storage_container" "blob" {
  count                 = var.enable_blob_service ? 1 : 0
  name                  = "blob-container"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

#---------------------------------------------------
# Enable File Share
#---------------------------------------------------
resource "azurerm_storage_share" "file_share" {
  count                = var.enable_file_service ? 1 : 0
  name                 = "file-share"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 100 # Size in GB
}

#---------------------------------------------------
# Enable Queue Service
#---------------------------------------------------
resource "azurerm_storage_queue" "queue" {
  count                = var.enable_queue_service ? 1 : 0
  name                 = "queue"
  storage_account_name = azurerm_storage_account.storage.name
}

#---------------------------------------------------
# Enable Table Service
#---------------------------------------------------
resource "azurerm_storage_table" "table" {
  count                = var.enable_table_service ? 1 : 0
  name                 = "waynes"
  storage_account_name = azurerm_storage_account.storage.name
}
