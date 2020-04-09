
provider "azurerm" {
  version         = "~> 2.4.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
    name     = var.resource-group-name
    location = var.resource-group-location
}

module "agw-module-appservice" {
  source = "./appservice"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}

module "vnet" {
  source = "./vnet"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}

module "vm" {
  source = "./vm"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
  subnet_frontend_id                                      = module.vnet.subnet_frontend_id
}

module "app-gateway" {
  source = "./appgw"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
  subnet_frontend_id                                      = module.vnet.subnet_frontend_id
  vnet_name                                               = module.vnet.name
  rajvent_pip_id                                          = module.vnet.rajvent_pip_id 
}

