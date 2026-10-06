resource "azurerm_kubernetes_cluster" "this" {
    name                = var.cluster_name
    location            = var.location
    resource_group_name = var.resource_group_name
    dns_prefix          = var.dns_prefix

    default_node_pool {
        name      = "default"
        node_count = var.node_count
        vm_size   = var.vm_size
        vnet_subnet_id = var.subnet_id
    }

    identity {type = "SystemAssigned"}

    network_profile {
        network_plugin    = "azure"
        service_cidr      = "10.1.0.0/16"
        dns_service_ip    = "10.1.0.10"
    }
  oms_agent {log_analytics_workspace_id = var.log_analytics_workspace_id}
}

# Create ans AKS cluster with the system managed identity and places its node pool inside our existing AKS subnet

# default_node_pool  - > Defines the worker machines that will run your Kubernetes workloads.
# node_count = var.node_count -> Controls how many Kubernetes worker nodes AKS creates.
# vm_size = var.vm_size -> Defines the Azure VM size used for each worker node.
# vnet_subnet_id = var.subnet_id -> Places the AKS nodes inside the subnet we already created.\
# identity {type = "SystemAssigned"} - > Gives AKS an Azure-managed identity that we can later use for secure Azure resource access.
# network_profile {network_plugin = "azure"}  -> Configure the aks to use azure cni networking plugin which allows pods to get IP addresses from the subnet and communicate with other resources in the VNet.