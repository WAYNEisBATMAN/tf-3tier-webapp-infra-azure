#---------------------------------------------------
# Monitoring Module Variables
#---------------------------------------------------

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources"
  type        = string
  default     = "Central India"
}

variable "vm_ids" {
  description = "List of VM IDs to monitor"
  type        = list(string)
}

variable "alert_email" {
  description = "Email address to send alerts to"
  type        = string
}
