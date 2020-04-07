
provider "azurerm" {
  version         = "~> 2.4.0"
  features {}
}
resource "azurerm_resource_group" "app-gw-poc" {
  name     = var.resource-group-name
  location = var.resource-group-location
}

module "agw-module-appservice" {
  source = "./appservice"
}
