resource "azurerm_app_service_plan" "poc" {
  name                = "api-appserviceplan"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "poc-app" {
  name                     = "agw-appservice-poc"
  location                 = var.resource-group-location
  resource_group_name      = var.resource-group-name
  app_service_plan_id      = azurerm_app_service_plan.poc.id
  site_config {
    linux_fx_version = "JAVA|11-java11"
    java_version = "11"
    java_container = "JAVA"
    java_container_version = "JAVA"
    ftps_state = "FtpsOnly"
    websockets_enabled = false
    always_on = true
    http2_enabled = true
  }
}