#---------------------------------------------------
# Root Module
#---------------------------------------------------

#---------------------------------------------------
# Compute Module
#---------------------------------------------------

output "vm_public_ips" {
  value = module.compute.vm_public_ips
}

output "vm_summary" {
  value = module.compute.vm_summary
}

output "lb_dns_name" {
  value = module.compute.lb_dns_name
}

#---------------------------------------------------
# Database Module
#---------------------------------------------------

output "sql_server_fqdn" {
  value = module.database.sql_server_fqdn
}

output "sql_database_name" {
  value = module.database.sql_database_name
}

output "cosmosdb_account_name" {
  value = module.database.cosmosdb_account_name
}

#---------------------------------------------------
# Storage Module
#---------------------------------------------------

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_container_name" {
  value = module.storage.container_name
}

#---------------------------------------------------
# Monitoring Module
#---------------------------------------------------

output "monitoring_alert_rule" {
  value = module.monitoring.alert_rule_name
}

#---------------------------------------------------
# Network Module
#---------------------------------------------------

output "vnet_id" {
  value = module.network.vnet_id
}

output "availability_zones" {
  value = module.network.availability_zones
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "web_nsg_id" {
  value = module.network.web_nsg_id
}

output "public_ip_ids" {
  value = module.network.public_ip_ids
}

output "internet_gateway_id" {
  description = "Azure equivalent: Internet-facing NAT / Public IPs"
  value       = module.network.internet_gateway_id
}
