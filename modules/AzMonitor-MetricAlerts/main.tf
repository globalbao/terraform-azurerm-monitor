resource "azurerm_monitor_metric_alert" "alert" {
  for_each                 = var.metricAlerts
  tags                     = var.tags
  name                     = each.value.alertName
  resource_group_name      = each.value.alertResourceGroupName
  scopes                   = each.value.alertScopes
  description              = each.value.alertDescription
  enabled                  = each.value.alertEnabled
  auto_mitigate            = each.value.alertAutoMitigate
  frequency                = each.value.alertFrequency
  window_size              = each.value.alertWindowSize
  severity                 = each.value.alertSeverity
  target_resource_type     = each.value.alertTargetResourceType
  target_resource_location = each.value.alertTargetResourceLoc

  dynamic_criteria {
    metric_namespace  = each.value.dynCriteriaMetricNamespace
    metric_name       = each.value.dynCriteriaMetricName
    aggregation       = each.value.dynCriteriaAggregation
    operator          = each.value.dynCriteriaOperator
    alert_sensitivity = each.value.dynCriteriaAlertSensitivity

    dynamic "dimension" {
      for_each = each.value.dynCriteriaDimensions
      content {
        name     = dimension.value["name"]
        operator = dimension.value["operator"]
        values   = [dimension.value["values"]]
      }
    }
  }
  action {
    action_group_id = each.value.actionGroupID
  }
}

resource "azurerm_monitor_metric_alert" "alert-nodimensions" {
  for_each                 = var.metricAlerts-noDimensions
  tags                     = var.tags
  name                     = each.value.alertName
  resource_group_name      = each.value.alertResourceGroupName
  scopes                   = each.value.alertScopes
  description              = each.value.alertDescription
  enabled                  = each.value.alertEnabled
  auto_mitigate            = each.value.alertAutoMitigate
  frequency                = each.value.alertFrequency
  window_size              = each.value.alertWindowSize
  severity                 = each.value.alertSeverity
  target_resource_type     = each.value.alertTargetResourceType
  target_resource_location = each.value.alertTargetResourceLoc
  
  dynamic_criteria {
    metric_namespace  = each.value.dynCriteriaMetricNamespace
    metric_name       = each.value.dynCriteriaMetricName
    aggregation       = each.value.dynCriteriaAggregation
    operator          = each.value.dynCriteriaOperator
    alert_sensitivity = each.value.dynCriteriaAlertSensitivity
  }
  action {
    action_group_id = each.value.actionGroupID
  }
}
