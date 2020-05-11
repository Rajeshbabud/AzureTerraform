locals {
  app-service-plan-id-list = [
    {
      planId = var.app-service-plan-poc-id,
      name  = "poc-appservice-plan"
    },

    {
      planId =var.app-service-plan-test-id,
      name  = "test-appservice-plan"
    }
  ]
}

resource "azurerm_monitor_action_group" "raj-actiongroup" {
  name                = "Rajesh-test-alertgroup"
  resource_group_name = var.resource-group-name
  short_name          = "testalert"

  webhook_receiver {
    name        = "MoogSoft"
    service_uri = "https://aiops.aa.com/ingestions/azure-lab"
    use_common_alert_schema = true
  }

}

resource "azurerm_monitor_metric_alert" "cpu-alert" {
  count               = length(app-service-plan-id-list)
  name                = "Rajesh-cpu-usage-alert-${app-service-plan-id-list[count.index].name}"
  resource_group_name = var.resource-group-name
  scopes              = app-service-plan-id-list[count.index].planId
  description         = "Action will be triggered when CPU usage is more than 90 percentage."
  severity            = 3
  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "CpuPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90

    dimension {
      name     = "Instance"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.raj-actiongroup.id
  }
}

resource "azurerm_monitor_metric_alert" "memory-alert" {
  name = "Rajesh-memory-usage-alert"
  resource_group_name = var.resource-group-name
  scopes = [var.app-service-plan-poc-id]
  description = "Action will be triggered when Memory usage is more than 90 percentage."
  severity            = 3
  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name = "MemoryPercentage"
    aggregation = "Average"
    operator = "GreaterThan"
    threshold = 90

    dimension {
      name = "Instance"
      operator = "Include"
      values = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.raj-actiongroup.id
  }
} 

