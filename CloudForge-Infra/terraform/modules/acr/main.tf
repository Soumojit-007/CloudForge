resource "azurerm_container_registry" "this" {
    name                     = var.acr_name
    resource_group_name      = var.resource_group_name
    location                 = var.location

    sku                      = "Basic"
    admin_enabled            = false
}


#  Creating an output variable for the ACR login supplied name, Resource Group and region