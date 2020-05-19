resource "azurerm_eventhub_namespace" "raj-eventhub-namespace" {
  name                = "raj-oh-eventhub"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  sku                 = "Standard"
  capacity            = 2
  auto_inflate_enabled = true
  maximum_throughput_units = 20
}