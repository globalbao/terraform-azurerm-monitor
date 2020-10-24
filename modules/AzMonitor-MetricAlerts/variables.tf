data "azurerm_resources" "existing" {
  for_each            = var.alertScope
  name                = each.value.resourceName
  resource_group_name = each.value.resourceGroup
  type                = each.value.resourceType
}

variable "alertScope" {
  type = map(object({
    resourceName  = string
    resourceGroup = string
    resourceType  = string
  }))
}

variable "metricAlerts" {
  type = map(object({
    alertName                   = string
    alertResourceGroupName      = string
    alertScopes                 = list(string)
    alertDescription            = string
    alertEnabled                = bool
    alertAutoMitigate           = bool
    alertFrequency              = string
    alertWindowSize             = string
    alertSeverity               = number
    alertTargetResourceType     = string
    alertTargetResourceLoc      = string
    dynCriteriaMetricNamespace  = string
    dynCriteriaMetricName       = string
    dynCriteriaAggregation      = string
    dynCriteriaOperator         = string
    dynCriteriaAlertSensitivity = string
    dynCriteriaDimensions       = list(map(string))
    actionGroupID               = string
  }))
  default = {}
}

variable "metricAlerts-noDimensions" {
  type = map(object({
    alertName                   = string
    alertResourceGroupName      = string
    alertScopes                 = list(string)
    alertDescription            = string
    alertEnabled                = bool
    alertAutoMitigate           = bool
    alertFrequency              = string
    alertWindowSize             = string
    alertSeverity               = number
    alertTargetResourceType     = string
    alertTargetResourceLoc      = string
    dynCriteriaMetricNamespace  = string
    dynCriteriaMetricName       = string
    dynCriteriaAggregation      = string
    dynCriteriaOperator         = string
    dynCriteriaAlertSensitivity = string
    actionGroupID               = string
  }))
  default = {}
}

variable "tags" {
  type = map
  default = {
    Application = "tbc"
    CostCentre  = "tbc"
    Environment = "tbc"
    ManagedBy   = "tbc"
    Owner       = "tbc"
    Support     = "tbc"
  }
}