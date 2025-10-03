#---------------------------------------------------
# Compute Module Outputs
#---------------------------------------------------

output "vm_ids" {
  description = "IDs of all virtual machines"
  value       = [for vm in azurerm_linux_virtual_machine.web : vm.id]
}

output "vm_public_ips" {
  description = "Public IP addresses of all VMs (if available)"
  value       = [for nic in azurerm_network_interface.web_nic : nic.private_ip_address]
}

output "load_balancer_id" {
  description = "Azure Load Balancer ID"
  value       = azurerm_lb.app_lb.id
}

output "load_balancer_frontend_ip" {
  description = "Frontend IP of the Load Balancer"
  value       = azurerm_lb.app_lb.frontend_ip_configuration[0].private_ip_address
}

output "backend_pool_id" {
  description = "Backend Address Pool ID for VMs"
  value       = azurerm_lb_backend_address_pool.web_bap.id
}
