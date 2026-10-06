resource_group_name = "cloudforge-dev-rg"
location            = "Central India"

vnet_name                   = "cloudforge-dev-vnet"
vnet_address_space          = ["10.0.0.0/16"]
aks_subnet_name             = "aks-subnet"
aks_subnet_address_prefixes = ["10.0.1.0/24"]
acr_name                    = "cloudforgedevacr001"


# Provides the actual AKS settings for the development environment.
aks_cluster_name = "cloudforge-dev-aks"
aks_dns_prefix   = "cloudforge-dev"
aks_node_count   = 1
aks_vm_size      = "Standard_B2s_v2"


