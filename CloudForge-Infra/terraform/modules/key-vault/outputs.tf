output "key_vault_name" {
    value = azurerm_key_vault.this.name
}

output "key_vault_id"{
    value = azurerm_key_vault.this.id
}

output "aks_identity_client_id" {
    value = azurerm_user_assigned_identity.aks.id
}