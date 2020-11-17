# AzureRM Monitor Metric Alerts Load Balancer - Terraform child module

* Vendor reference [https://www.terraform.io/docs/providers/azurerm/r/monitor_metric_alert.html](https://www.terraform.io/docs/providers/azurerm/r/monitor_metric_alert.html)

## Child module files

* `main.tf`
* `outputs.tf`
* `variables.tf`

## Terraform resources (main.tf)

Resource Type| Resource name| Deployment Count
:------------|:-------------|:-----
azurerm_monitor_metric_alert|alert|count varies according to `metricAlerts` variable inputs
azurerm_monitor_metric_alert|alert-nodimensions|count varies according to `metricAlerts-nodimensions` variable inputs


## Input variables (variables.tf)

Name|Description|Type|Default Value
|:--|:----------|:---|:--------------
|`alertScope`|key=value arguments for Azure Monitor Metric Alerts|`map of objects`| N/A
|`metricAlerts`|key=value arguments for Azure Monitor Metric Alerts|`map of objects`| N/A
|`metricAlerts-noDimensions`|key=value arguments for Azure Monitor Metric Alerts with no criteria dimensions|`map of objects`| N/A

## Output variables (outputs.tf)

Name|Description|Value
|:--|:--------- |:----
|`alert-scope`|The Load Balancers to scope the alerts to|data.azurerm_resources.existing.*
|`metric-alerts`|The Azure Monitor Metric Alerts created|azurerm_monitor_metric_alert.alert
|`metric-alerts-nodimensions`|The Azure Monitor Metric Alerts with no criteria dimensions created|azurerm_monitor_metric_alert.alert-nodimensions

### Child module example usage

```terraform

 module "azmonitor-metric-alerts" {
  source = "git::ssh://git@https://github.com/globalbao/terraform-azurerm-monitor//modules/AzMonitor-MetricAlerts?ref=v1.0"

  tags = {
    Application = "Azure Monitor Alerts"
    CostCentre  = "123"
    Environment = "dev"
    ManagedBy   = "Jesse Loudon"
    Owner       = "Jesse Loudon"
    Support     = "coder_au@outlook.com"
  }

  alertScope = {
    "resource1" = {
      resourceName  = "azmonloadbalancer1"
      resourceGroup = "DevResources"
      resourceType  = "Microsoft.Network/loadBalancers"
    },
    "resource2" = {
      resourceName  = "azmonappgateway1"
      resourceGroup = "DevResources"
      resourceType  = "Microsoft.Network/appGateway"
    },
    "resource3" = {
      resourceName  = "azmonsqldb1"
      resourceGroup = "DevResources"
      resourceType  = "Microsoft.Sql/managedInstances"
    }
  }

  metricAlerts = {
    "alert1" = {
      alertName              = "azmonloadbalancer1-DipAvailability"
      alertResourceGroupName = "DevResources"
      alertScopes = [
        module.azmonitor-metric-alerts.alert-scope["0"].resource1.resources[0].id
      ]
      alertDescription            = "Average Load Balancer health probe status per time duration"
      alertEnabled                = "true"
      alertAutoMitigate           = "true"
      alertFrequency              = "PT15M"
      alertWindowSize             = "PT1H"
      alertSeverity               = "2"
      alertTargetResourceType     = "Microsoft.Network/loadBalancers"
      alertTargetResourceLoc      = "australiaeast"
      dynCriteriaMetricNamespace  = "Microsoft.Network/loadBalancers"
      dynCriteriaMetricName       = "DipAvailability"
      dynCriteriaAggregation      = "Average"
      dynCriteriaOperator         = "LessThan"
      dynCriteriaAlertSensitivity = "Medium"
      dynCriteriaDimensions = [
        {
          name     = "ProtocolType"
          operator = "Include"
          values   = "*"
        },
        {
          name     = "FrontendIPAddress"
          operator = "Include"
          values   = "*"
        },
        {
          name     = "BackendIPAddress"
          operator = "Include"
          values   = "*"
        },
      ]
      actionGroupID = module.azmonitor-action-groups.ag["0"].group1.id
    },
    "alert2" = {
      alertName              = "azmonloadbalancer1-VipAvailability"
      alertResourceGroupName = "DevResources"
      alertScopes = [
        module.azmonitor-metric-alerts.alert-scope["0"].resource1.resources[0].id
      ]
      alertDescription            = "Average Load Balancer data path availability per time duration"
      alertEnabled                = "true"
      alertAutoMitigate           = "true"
      alertFrequency              = "PT15M"
      alertWindowSize             = "PT1H"
      alertSeverity               = "2"
      alertTargetResourceType     = "Microsoft.Network/loadBalancers"
      alertTargetResourceLoc      = "australiaeast"
      dynCriteriaMetricNamespace  = "Microsoft.Network/loadBalancers"
      dynCriteriaMetricName       = "VipAvailability"
      dynCriteriaAggregation      = "Average"
      dynCriteriaOperator         = "LessThan"
      dynCriteriaAlertSensitivity = "Medium"
      dynCriteriaDimensions = [
        {
          name     = "FrontendPort"
          operator = "Include"
          values   = "*"
        },
        {
          name     = "FrontendIPAddress"
          operator = "Include"
          values   = "*"
        },
      ]
      actionGroupID = module.azmonitor-action-groups.ag["0"].group2.id
    },
    "alert3" = {
      alertName              = "azmonappgateway1-UnhealthyHostcount"
      alertResourceGroupName = "DevResources"
      alertScopes = [
        module.azmonitor-metric-alerts.alert-scope["0"].resource2.resources[0].id
      ]
      alertDescription            = "Current UnhealthyHostcount of the Application Gateway"
      alertEnabled                = "true"
      alertAutoMitigate           = "true"
      alertFrequency              = "PT15M"
      alertWindowSize             = "PT1H"
      alertSeverity               = "2"
      alertTargetResourceType     = "Microsoft.Network/applicationGateways"
      alertTargetResourceLoc      = "australiaeast"
      dynCriteriaMetricNamespace  = "Microsoft.Network/applicationGateways"
      dynCriteriaMetricName       = "UnhealthyHostcount"
      dynCriteriaAggregation      = "Average"
      dynCriteriaOperator         = "GreaterThan"
      dynCriteriaAlertSensitivity = "Medium"
      dynCriteriaDimensions = [
        {
          name     = "BackendSettingsPool"
          operator = "Include"
          values   = "*"
        }
      ]
      actionGroupID = module.azmonitor-action-groups.ag["0"].group1.id
    },
    "alert4" = {
      alertName              = "azmonappgateway1-FailedRequests"
      alertResourceGroupName = "DevResources"
      alertScopes = [
        module.azmonitor-metric-alerts.alert-scope["0"].resource2.resources[0].id
      ]
      alertDescription            = "Count of failed requests that Application Gateway has served"
      alertEnabled                = "true"
      alertAutoMitigate           = "true"
      alertFrequency              = "PT15M"
      alertWindowSize             = "PT1H"
      alertSeverity               = "2"
      alertTargetResourceType     = "Microsoft.Network/applicationGateways"
      alertTargetResourceLoc      = "australiaeast"
      dynCriteriaMetricNamespace  = "Microsoft.Network/applicationGateways"
      dynCriteriaMetricName       = "FailedRequests"
      dynCriteriaAggregation      = "Total"
      dynCriteriaOperator         = "GreaterThan"
      dynCriteriaAlertSensitivity = "Medium"
      dynCriteriaDimensions = [
        {
          name     = "BackendSettingsPool"
          operator = "Include"
          values   = "*"
        }
      ]
      actionGroupID = module.azmonitor-action-groups.ag["0"].group1.id
    }
  }

  metricAlerts-noDimensions = {
    "alert1" = {
      alertName              = "azmonsqldb1-avg_cpu_percent"
      alertResourceGroupName = "DevResources"
      alertScopes = [
        module.azmonitor-metric-alerts.alert-scope["0"].resource3.resources[0].id
      ]
      alertDescription            = "Average CPU percentage"
      alertEnabled                = "true"
      alertAutoMitigate           = "true"
      alertFrequency              = "PT15M"
      alertWindowSize             = "PT1H"
      alertSeverity               = "3"
      alertTargetResourceType     = "Microsoft.Sql/managedInstances"
      alertTargetResourceLoc      = "australiaeast"
      dynCriteriaMetricNamespace  = "Microsoft.Sql/managedInstances"
      dynCriteriaMetricName       = "avg_cpu_percent"
      dynCriteriaAggregation      = "Average"
      dynCriteriaOperator         = "GreaterThan"
      dynCriteriaAlertSensitivity = "Medium"
      actionGroupID               = module.azmonitor-action-groups.ag["0"].group2.id
    }
  }
}
```