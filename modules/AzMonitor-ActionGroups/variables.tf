variable "actionGroups" {
  type = map(object({
    actionGroupName          = string
    actionGroupShortName     = string
    actionGroupRGName        = string
    actionGroupEnabled       = string
    actionGroupEmailReceiver = list(map(string))
  }))
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