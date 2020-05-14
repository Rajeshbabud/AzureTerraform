output "loganalytics-workspace-id" {
  value       = azurerm_log_analytics_workspace.loganalytics.id
  description = "The log analytics workspace id."
  sensitive   = true
}