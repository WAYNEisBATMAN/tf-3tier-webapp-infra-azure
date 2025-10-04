variable "keyvault_name" {
  description = "Key Vault name (must be globally unique)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "admin_username" {
  description = "VM admin username"
  type        = string
  sensitive   = true
}

