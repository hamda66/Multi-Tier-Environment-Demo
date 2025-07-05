

resource "azurerm_monitor_autoscale_setting" "app_vmss_autoscale" {
  name                = "app-vmss-autoscale-${var.resource_grp_name}"
  resource_group_name = azurerm_resource_group.rg.name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.app_vmss.id
  location            = azurerm_resource_group.rg.location

  enabled = true

  profile {
    name = "default"

    capacity {
      minimum = "1"
      maximum = "5"
      default = "1"
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.app_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"

        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction          = "Increase"
        type               = "ChangeCount"
        value              = "1"
        cooldown           = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.app_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"

        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction          = "Decrease"
        type               = "ChangeCount"
        value              = "1"
        cooldown           = "PT5M"
      }
    }
  }
  
}