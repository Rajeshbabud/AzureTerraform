resource "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "raj-loganalytics"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}