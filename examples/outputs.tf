output "azmonitor-actiongroups" {
  value = module.azmonitor-action-groups.ag
}

output "azmonitor-alert-scope" {
  value = module.azmonitor-metric-alerts.alert-scope
}

output "azmonitor-metric-alerts" {
  value = module.azmonitor-metric-alerts.metric-alerts
}

output "metric-alerts-nodimensions" {
  value = module.azmonitor-metric-alerts.metric-alerts-nodimensions
}