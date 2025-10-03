#---------------------------------------------------
# Compute Module Variables
#---------------------------------------------------

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region to deploy compute resources"
  type        = string
  default     = "Central India"
}

variable "instance_count" {
  description = "Number of VMs to deploy"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VMs"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs to deploy VMs"
  type        = list(string)
  default     = []
}

variable "nsg_id" {
  description = "Network Security Group ID to attach to VMs"
  type        = string
}
