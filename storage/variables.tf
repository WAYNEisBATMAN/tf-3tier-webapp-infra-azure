#---------------------------------------------------
# Storage Module Variables
#---------------------------------------------------

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region to deploy storage"
  type        = string
  default     = "Central India"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account (must be globally unique)"
  type        = string
  default     = "mystorageacc${random_string.suffix.result}"
}

variable "enable_blob_service" {
  description = "Enable Blob service"
  type        = bool
  default     = true
}

variable "enable_file_service" {
  description = "Enable File service"
  type        = bool
  default     = true
}

variable "enable_queue_service" {
  description = "Enable Queue service"
  type        = bool
  default     = true
}

variable "enable_table_service" {
  description = "Enable Table service"
  type        = bool
  default     = true
}

variable "account_tier" {
  description = "Azure Storage Account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"  # Options: LRS, GRS, ZRS, RA-GRS, etc.
}
