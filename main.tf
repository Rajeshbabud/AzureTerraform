
provider "azurerm" {
  version         = "~> 2.4.0"
  features {}
}
module "agw-module-appservice" {
  source = "./appservice"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = var.resource-group-name
}
