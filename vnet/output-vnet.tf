output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
  description = "The vnet id."
  sensitive = true
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_frontend_id" {
  description = "The ids of subnets created inside the newl vNet"
  value       = azurerm_subnet.frontend.id
}

output "subnet_backend_id" {
  description = "The ids of subnets created inside the newl vNet"
  value       = azurerm_subnet.backend.id
}

output "subnet_vm_id" {
  description = "The ids of subnets created inside the newl vNet"
  value       = azurerm_subnet.vmsubnet.id
}

output "rajvent_pip_id" {
  description = "The ids of Public IP"
  value       = azurerm_public_ip.pip.id
}
