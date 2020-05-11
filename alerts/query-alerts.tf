data "azurerm_monitor_action_group" "raj-actiongroup" {
  name                = Rajesh-test-alertgroup
  resource_group_name = var.resource-group-name
}


resource "azurerm_monitor_scheduled_query_rules_alert" "example" {
  name                = "Rajesh-custom-query"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name

  action {
    action_group           = [data.azurerm_monitor_action_group.raj-actiongroup.id]
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