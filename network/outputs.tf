#---------------------------------------------------
# Network Outputs
#---------------------------------------------------

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Virtual Network Name"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "List of all subnet IDs"
  value       = [for s in azurerm_subnet.subnet : s.id]
}

output "nsg_id" {
  description = "ID of the Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}

output "subnet_names" {
  description = "Names of all subnets"
  value       = [for s in azurerm_subnet.subnet : s.name]
}
