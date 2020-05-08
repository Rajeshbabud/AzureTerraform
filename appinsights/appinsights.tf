
resource "azurerm_application_insights" "appinsights" {
  name                = "raj-appinsights"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  application_type    = "java"
}