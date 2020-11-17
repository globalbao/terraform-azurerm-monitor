# AzureRM Monitor Action Groups - Terraform child module

* Vendor reference [https://www.terraform.io/docs/providers/azurerm/r/monitor_action_group.html](https://www.terraform.io/docs/providers/azurerm/r/monitor_action_group.html)

## Child module files

* `main.tf`
* `outputs.tf`
* `variables.tf`

## Terraform resources (main.tf)

Resource Type|Resource name| Deployment Count
|:---------  |:------------|:------------
azurerm_monitor_action_group|actiongroup|count varies according to `actionGroups` variable inputs

## Input variables (variables.tf)

Name|Description|Type|Default Value
|:-- |:----      |:---|:--------------
|`actionGroups`|key=value arguments for Azure Monitor Action Groups|`map of objects`| N/A

## Output variables (outputs.tf)

Name|Description|Value
|:--|:--------- |:----
|`ag`|The Azure Monitor Action Groups created|azurerm_monitor_action_group.actiongroup.*

### Child module example usage

```terraform

module "azmonitor-action-groups" {
  source = "git::ssh://git@https://github.com/globalbao/terraform-azurerm-monitor//modules/AzMonitor-ActionGroups?ref=v1.0"

  tags = {
    Application = "Azure Monitor Alerts"
    CostCentre  = "123"
    Environment = "dev"
    ManagedBy   = "Jesse Loudon"
    Owner       = "Jesse Loudon"
    Support     = "coder_au@outlook.com"
  }

  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = "AzMonitorAlertGroups"
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "jloudon"
          email_address           = "coder_au@outlook.com"
          use_common_alert_schema = "true"
        }
      ]
    },
    "group2" = {
      actionGroupName      = "AlertOperationsGroup"
      actionGroupShortName = "alertops"
      actionGroupRGName    = "AzMonitorAlertGroups"
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "jloudon"
          email_address           = "coder_au@outlook.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}

```