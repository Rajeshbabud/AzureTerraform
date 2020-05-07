resource "azurerm_monitor_action_group" "ccs-actiongroup" {
  name                = "vijay-dev-alertgroup"
  resource_group_name = var.resource-group-name
  short_name          = "testalert"
}

resource "azurerm_monitor_metric_alert" "cpu-alert" {
  name                = "cpu-usage-alert"
  resource_group_name = var.resource-group-name
  scopes              = [var.app-service-plan-poc-id]
  description         = "Action will be triggered when CPU usage is more than 70 percentage."

  criteria {
    metric_namespace = "Microsoft.Web/servefarms"
    metric_name      = "CpuPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1

    dimension {
      name     = "Instance"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.ccs-actiongroup.id
  }
}

resource "azurerm_monitor_metric_alert" "memory-alert" {
  name = "memory-usage-alert"
  resource_group_name = var.resource-group-name
  scopes = [var.app-service-plan-poc-id]
  description = "Action will be triggered when Memory usage is more than 50 percentage."

  criteria {
    metric_namespace = "Microsoft.Web/servefarms"
    metric_name = "MemoryPercentage"
    aggregation = "Average"
    operator = "GreaterThan"
    threshold = 1

    dimension {
      name = "Instance"
      operator = "Include"
      values = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.ccs-actiongroup.id
  }
} 