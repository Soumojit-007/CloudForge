# resource "azurerm_resource_group" "cloudforge" {
#   name     = "cloudforge-dev-rg"
#   location = "East US"
# }

module "resource_group" {
  source = "../../terraform/modules/resource-group"

  name     = var.resource_group_name
  location = var.location
}

module "networking" {
  source = "../../terraform/modules/networking"

  resource_group_name         = module.resource_group.name
  location                    = var.location
  vnet_name                   = var.vnet_name
  vnet_address_space          = var.vnet_address_space
  aks_subnet_name             = var.aks_subnet_name
  aks_subnet_address_prefixes = var.aks_subnet_address_prefixes
}

#  Terraform, use the Resource Group module located at ../../modules/resource-group and give it these values.
module "acr" {
  source = "../../terraform/modules/acr"

  acr_name            = var.acr_name
  resource_group_name = module.resource_group.name
  location            = var.location
}


# Calls the AKS module and connects it to the Resource Group and AKS subnet we already created.
module "aks" {
  source = "../../terraform/modules/aks"


  cluster_name               = var.aks_cluster_name
  location                   = var.location
  resource_group_name        = module.resource_group.name
  subnet_id                  = module.networking.aks_subnet_id
  dns_prefix                 = var.aks_dns_prefix
  node_count                 = var.aks_node_count
  vm_size                    = var.aks_vm_size
  log_analytics_workspace_id = module.monitoring.workspace_id
}


# This is the storage section
module "storage" {
  source = "../../terraform/modules/storage"

  storage_account_name = "cloudforgestatedev001"
  resource_group_name  = module.resource_group.name
  location             = var.location

  tags = {
    Environment = "dev"
    Project     = "CloudForge"
  }
}

# key-vault section
module "key_vault" {
  source = "../../terraform/modules/key-vault"

  key_vault_name      = "cloudforge-dev-kv"
  location            = var.location
  resource_group_name = module.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = {
    Environment = "dev"
    Project     = "CloudForge"
  }
}


# Monitoring Section
module "monitoring" {
  source = "../../terraform/modules/monitoring"

  workspace_name      = "cloudforge-dev-law"
  location            = var.location
  resource_group_name = module.resource_group.name

  tags = {
    Environment = "dev"
    Project     = "CloudForge"
  }
}
# module "resource_group"
#         │
#         │ name = cloudforge-dev-rg
#         │ location = East US
#         ↓
# modules/resource-group/
#         │
#         ├── variables.tf
#         ├── main.tf
#         └── outputs.tf
#         │
#         ↓
# Azure Resource Group