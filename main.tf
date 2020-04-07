
provider "azurerm" {
  version         = "~> 2.4.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
    name     = "app-gw-poc"
    location = var.resource-group-location
}
module "agw-module-appservice" {
  source = "./appservice"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}
