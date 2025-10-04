#---------------------------------------------------
# Log Analytics Workspace
#---------------------------------------------------
resource "azurerm_log_analytics_workspace" "law" {
  name                = "log-analytics-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#---------------------------------------------------
# Azure Monitor Action Group for Alerts
#---------------------------------------------------
resource "azurerm_monitor_action_group" "alert_group" {
  name                = "alert-action-group"
  resource_group_name = var.resource_group_name
  short_name          = "alerts"

  email_receiver {
    name          = "alert-email"
    email_address = var.alert_email
  }
}


#---------------------------------------------------
# Metric Alert for CPU Usage
#---------------------------------------------------
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-usage-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.vm_ids
  description         = "Alert when average CPU > 80% for 5 minutes"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"
  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }
  action {
    action_group_id = azurerm_monitor_action_group.alert_group.id
  }
}
