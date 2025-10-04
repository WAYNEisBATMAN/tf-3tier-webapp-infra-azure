#---------------------------------------------------
# Root Outputs - 3-Tier Web Application Infrastructure
#---------------------------------------------------

#---------------------------------------------------
# Keyvault Module Outputs
#---------------------------------------------------

output "keyvault_name" {
  description = "Key Vault Name"
  value       = module.keyvault.keyvault_id
}

output "keyvault_uri" {
  description = "Key Vault URI"
  value       = module.keyvault.keyvault_uri
}


#---------------------------------------------------
# Network Module Outputs
#---------------------------------------------------
output "vnet_id" {
  description = "Virtual Network ID"
  value       = module.network.vnet_id
}

output "vnet_name" {
  description = "Virtual Network Name"
  value       = module.network.vnet_name
}

output "subnet_ids" {
  description = "List of Subnet IDs"
  value       = module.network.subnet_ids
}

output "nsg_id" {
  description = "Network Security Group ID"
  value       = module.network.nsg_id
}

#---------------------------------------------------
# Compute Module Outputs
#---------------------------------------------------
output "vm_ids" {
  description = "List of Virtual Machine IDs"
  value       = module.compute.vm_ids
}

output "vm_names" {
  description = "List of Virtual Machine Names"
  value       = module.compute.vm_names
}


output "load_balancer_id" {
  description = "Load Balancer ID"
  value       = module.compute.load_balancer_id
}

output "load_balancer_public_ip" {
  description = "Load Balancer Public IP Address"
  value       = module.compute.load_balancer_public_ip
}

output "load_balancer_frontend_ip" {
  description = "Load Balancer Frontend IP Configuration"
  value       = module.compute.load_balancer_frontend_ip
}

#---------------------------------------------------
# Database Module Outputs
#---------------------------------------------------
output "sql_server_name" {
  description = "Azure SQL Server Name"
  value       = module.database.sql_server_name
}

output "sql_server_fqdn" {
  description = "Azure SQL Server Fully Qualified Domain Name"
  value       = module.database.sql_server_fqdn
}

output "sql_database_name" {
  description = "Azure SQL Database Name"
  value       = module.database.sql_database_name
}

output "mysql_server_name" {
  description = "MySQL Flexible Server Name"
  value       = module.database.mysql_server_name
}

output "mysql_server_fqdn" {
  description = "MySQL Flexible Server FQDN"
  value       = module.database.mysql_server_fqdn
}

output "mysql_database_name" {
  description = "MySQL Database Name"
  value       = module.database.mysql_database_name
}

output "cosmosdb_account_name" {
  description = "Cosmos DB Account Name"
  value       = module.database.cosmosdb_account_name
}

output "cosmosdb_endpoint" {
  description = "Cosmos DB Endpoint"
  value       = module.database.cosmosdb_endpoint
}

output "cosmosdb_database_name" {
  description = "Cosmos DB Database Name"
  value       = module.database.cosmosdb_database_name
}

#---------------------------------------------------
# Storage Module Outputs
#---------------------------------------------------
output "storage_account_name" {
  description = "Storage Account Name"
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "Storage Account ID"
  value       = module.storage.storage_account_id
}

output "storage_primary_blob_endpoint" {
  description = "Primary Blob Storage Endpoint"
  value       = module.storage.primary_blob_endpoint
}

output "storage_primary_file_endpoint" {
  description = "Primary File Storage Endpoint"
  value       = module.storage.primary_file_endpoint
}

output "storage_primary_queue_endpoint" {
  description = "Primary Queue Storage Endpoint"
  value       = module.storage.primary_queue_endpoint
}

output "storage_primary_table_endpoint" {
  description = "Primary Table Storage Endpoint"
  value       = module.storage.primary_table_endpoint
}

output "blob_container_name" {
  description = "Blob Container Name"
  value       = module.storage.blob_container_name
}

output "file_share_name" {
  description = "File Share Name"
  value       = module.storage.file_share_name
}

#---------------------------------------------------
# Monitoring Module Outputs
#---------------------------------------------------
output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = module.monitoring.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace Name"
  value       = module.monitoring.log_analytics_workspace_name
}


output "monitor_action_group_id" {
  description = "Monitor Action Group ID"
  value       = module.monitoring.monitor_action_group_id
}

output "cpu_metric_alert_id" {
  description = "CPU Metric Alert ID"
  value       = module.monitoring.cpu_metric_alert_id
}

#---------------------------------------------------
# Summary Outputs
#---------------------------------------------------
output "application_url" {
  description = "Application URL via Load Balancer"
  value       = "http://${module.compute.load_balancer_public_ip}"
}

output "resource_group_name" {
  description = "Resource Group Name"
  value       = var.resource_group_name
}

output "deployment_region" {
  description = "Azure Region where resources are deployed"
  value       = var.location
}

output "deployment_summary" {
  description = "Deployment Summary"
  value = {
    resource_group = var.resource_group_name
    location       = var.location
    vms_count      = length(module.compute.vm_ids)
    subnets_count  = length(module.network.subnet_ids)
    databases      = {
      sql_server = module.database.sql_server_name
      mysql      = module.database.mysql_server_name
      cosmosdb   = module.database.cosmosdb_account_name
    }
    storage_account = module.storage.storage_account_name
    monitoring      = {
      log_analytics = module.monitoring.log_analytics_workspace_name
      alerts        = "Enabled"
    }
  }
}