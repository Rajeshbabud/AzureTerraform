resource "azurerm_eventhub_namespace" "raj-eventhub-namespace" {
  name                = "eventhub-raj"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  sku                 = "Standard"
  capacity            = 2
  auto_inflate_enabled = true
  maximum_throughput_units = 20
  tags = var.resource-group-tags
}