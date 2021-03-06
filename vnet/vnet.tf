resource "azurerm_virtual_network" "vnet" {
    name                = "rajvnet"
    location            = var.resource-group-location
    resource_group_name = var.resource-group-name
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
}
 
resource "azurerm_subnet" "frontend" {
    name                = "frontend"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = var.resource-group-name
    address_prefix      = "10.0.1.0/24"
}

resource "azurerm_subnet" "vm" {
    name                = "vmsubnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = var.resource-group-name
    address_prefix      = "10.0.2.0/24"
}

resource "azurerm_subnet" "backend" { 
    name                = "backend"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = var.resource-group-name
    address_prefix      = "10.0.3.0/24"
}

resource "azurerm_public_ip" "pip" {
    name                = "rajvnet-pip"
    location            = var.resource-group-location
    resource_group_name = var.resource-group-name
    allocation_method   = "Dynamic"
}
