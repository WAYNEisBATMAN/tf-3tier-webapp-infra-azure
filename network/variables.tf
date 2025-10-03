#---------------------------------------------------
# Network Variables
#---------------------------------------------------

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "Central India"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "my-vnet"
}

variable "vnet_cidr" {
  description = "CIDR block for the Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  description = "List of subnet CIDR prefixes"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
  default     = "web-nsg"
}

variable "allow_ssh" {
  description = "Allow SSH (port 22) inbound"
  type        = bool
  default     = true
}

variable "allow_http" {
  description = "Allow HTTP (port 80) inbound"
  type        = bool
  default     = true
}
