
provider "azurerm" {
  version         = "~> 2.4.0"
}
resource "azurerm_resource_group" "app-gw-poc" {
  name     = var.resource-group-name
  location = var.resource-group-location
}