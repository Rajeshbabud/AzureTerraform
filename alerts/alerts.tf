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
  name                = "Rajesh-cpu-usage-alert"
  resource_group_name = var.resource-group-name
  scopes              = [var.app-service-plan-poc-id]
  description         = "Action will be triggered when CPU usage is more than 70 percentage."

  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
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
    action_group_id = azurerm_monitor_action_group.raj-actiongroup.id
  }
}

resource "azurerm_monitor_metric_alert" "memory-alert" {
  name = "Rajesh-memory-usage-alert"
  resource_group_name = var.resource-group-name
  scopes = [var.app-service-plan-poc-id]
  description = "Action will be triggered when Memory usage is more than 50 percentage."

  criteria {
    metric_namespace = "Microsoft.Web/serverfarms"
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
    action_group_id = azurerm_monitor_action_group.raj-actiongroup.id
  }
} 

resource "azurerm_monitor_scheduled_query_rules_alert" "example" {
  name                = "Rajesh-custom-query"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name

  action {
    action_group           = azurerm_monitor_action_group.raj-actiongroup.id
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = var.appinsights_id
  description    = "Alert when total results cross threshold"
  enabled        = true
  # Count all requests with server error result code grouped into 5-minute bins
  query       = <<-QUERY
  traces
    | where message contains "Exception" and cloud_RoleInstance == "aa-oh-test-appservice-ccs"  
  QUERY
  severity    = 1
  frequency   = 5
  time_window = 30
  trigger {
    operator  = "GreaterThan"
    threshold = 3
  }
}