resource "azurerm_user_assigned_identity" "aks" {
  name = "cloudforge-aks-kv-identity"
  location = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}


resource "azurerm_role_assignment" "aks_secrets_user"{
  scope = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id = azurerm_user_assigned_identity.aks.principal_id
}