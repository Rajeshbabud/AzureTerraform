
provider "azurerm" {
  version         = "~> 2.4.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
    name     = var.resource-group-name
    location = var.resource-group-location
}

module "appservice" {
  source = "./appservice"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}

module "alerts" {
  source = "./alerts"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}



