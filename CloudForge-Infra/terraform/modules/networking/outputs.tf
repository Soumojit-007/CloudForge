output "vnet_id" {
    description = "ID of the cloudforge-dev Virtual Network"
    value       = azurerm_virtual_network.this.name
}

output "vnet_name" {
    description = "Name of the cloudforge virtual network"
    value       = azurerm_virtual_network.this.name
}

output "aks_subnet_id" {
    description = "ID of the AKS subnet"
    value =      azurerm_subnet.aks.id
}

output "aks_subnet_name" {
    description = "Name of the AKS subnet"
    value =      azurerm_subnet.aks.name
}