#---------------------------------------------------
# Compute Module Outputs
#---------------------------------------------------


output "vm_ids" {
  description = "List of all VM resource IDs"
  value       = azurerm_linux_virtual_machine.web[*].id
}

output "vm_names" {
  description = "List of VM names"
  value       = azurerm_linux_virtual_machine.web[*].name
}


output "load_balancer_public_ip" {
  description = "Load Balancer Public IP Address"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

output "vm_private_ips" {
  description = "List of VM private IP addresses"
  value       = azurerm_linux_virtual_machine.web[*].private_ip_address
}

output "vm_public_ips" {
  description = "Public IP addresses of VMs for SSH access"
  value       = azurerm_public_ip.vm_public_ip[*].ip_address
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
