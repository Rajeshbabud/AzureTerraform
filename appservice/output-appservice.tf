output "app-service-plan-poc-id" {
  value = azurerm_app_service_plan.poc.id
  description = "The apis app service plan id."
  sensitive = true
}