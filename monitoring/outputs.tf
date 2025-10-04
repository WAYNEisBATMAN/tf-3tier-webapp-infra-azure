#---------------------------------------------------
# Monitoring Module Outputs
#---------------------------------------------------

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.law.id
}

output "monitor_action_group_id" {
  description = "ID of the Alert Action Group"
  value       = azurerm_monitor_action_group.alert_group.id
}

output "cpu_metric_alert_id" {
  description = "ID of the CPU metric alert"
  value       = azurerm_monitor_metric_alert.cpu_alert.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace Name"
  value       = azurerm_log_analytics_workspace.law.name
}
