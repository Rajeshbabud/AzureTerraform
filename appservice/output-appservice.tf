output "app-service-plan-poc-id" {
  value = azurerm_app_service_plan.poc.id
  description = "The poc app service plan id."
  sensitive = true
}

output "app-service-plan-test-id" {
  value = azurerm_app_service_plan.test.id
  description = "The test app service plan id."
  sensitive = true
}

output "app-service-poc-id" {
  value = azurerm_app_service.poc-app.id
  description = "The poc app service id."
  sensitive = true
}
