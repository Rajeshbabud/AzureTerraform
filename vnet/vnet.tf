resource "azurerm_virtual_network" "vnet" {
  name                = "rajvnet"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}