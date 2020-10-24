output "alert-scope" {
  value = data.azurerm_resources.existing.*
}

output "metric-alerts" {
  value = azurerm_monitor_metric_alert.alert
}

output "metric-alerts-nodimensions" {
  value = azurerm_monitor_metric_alert.alert-nodimensions
}