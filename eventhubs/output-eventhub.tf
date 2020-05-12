output "eventhubs-raj-id" {
  value = azurerm_eventhub_namespace.raj-eventhub-namespace.id
  description = "internal eventshub namespace ID."
  sensitive = true
}