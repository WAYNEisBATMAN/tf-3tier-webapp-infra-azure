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
  description = "Storage account name prefix (suffix will be auto-generated)"
  type        = string
  default     = "tfstore" # Just a simple prefix

  validation {
    condition     = length(var.storage_account_name) <= 16
    error_message = "Storage account name prefix must be 16 characters or less to allow for random suffix."
  }
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
  default     = "LRS" # Options: LRS, GRS, ZRS, RA-GRS, etc.
}
