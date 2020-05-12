resource "azurerm_monitor_metric_alert" "throttled-requests" {
  name                = "throttled-requests"
  scopes              = [var.eventhubs-raj-id]
  resource_group_name = var.resource-group-name
  description         = "Action will be triggered when throttled requests exceeds 100."

  criteria {
    metric_namespace = "Microsoft.EventHub/namespaces"
    metric_name      = "ThrottledRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 100

    dimension {
      name     = "EntityName"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "OperationResult"
      operator = "Include"
      values   = ["*"]
    }
  }