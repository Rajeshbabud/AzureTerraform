
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

module "eventhub" {
  source = "./eventhubs"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}


module "alerts" {
  source = "./alerts"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
  app-service-plan-poc-id                                 = module.appservice.app-service-plan-poc-id
  app-service-poc-id                                      = module.appservice.app-service-poc-id
  app-service-plan-test-id                                = module.appservice.app-service-plan-test-id
  appinsights_id                                          = module.appinsights.appinsights_id
  eventhubs-raj-id                                        = module.eventhub.eventhubs-raj-id
  loganalytics-workspace-id                               = module.loganalytics.loganalytics-workspace-id
  query                                                   = "<<-QUERY AppServiceConsoleLogs | where _ResourceId contains 'cdr' and ResultDescription contains 'ClientKafkaTemplate Sucessfully written message to Client topic' | summarize  count() QUERY"
}

module "appinsights" {
  source = "./appinsights"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}

module "loganalytics" {
  source = "./loganalytics"
  resource-group-location                                 = var.resource-group-location
  resource-group-name                                     = azurerm_resource_group.rg.name
}

#module "vnet" {
#  source = "./vnet"
#  resource-group-location                                 = var.resource-group-location
#  resource-group-name                                     = azurerm_resource_group.rg.name
#}

#module "vm" {
#  source = "./vm"
#  resource-group-location                                 = var.resource-group-location
#  resource-group-name                                     = azurerm_resource_group.rg.name
#  subnet_vm_id                                            = module.vnet.subnet_vm_id
#}

#module "app-gateway" {
#  source = "./appgw"
#  resource-group-location                                 = var.resource-group-location
#  resource-group-name                                     = azurerm_resource_group.rg.name
#  subnet_frontend_id                                      = module.vnet.subnet_frontend_id
#  vnet_name                                               = module.vnet.vnet_name
#  rajvent_pip_id                                          = module.vnet.rajvent_pip_id 
#}

