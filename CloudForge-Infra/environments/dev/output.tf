output "resource_group_name" {
  description = "Name of the Cloudforge developement Resource Group"
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "ID of the CloudForge development Resource Group"
  value       = module.resource_group.id
}

output "resource_group_location" {
  description = "Location of the CloudForge development Resource Group"
  value       = module.resource_group.location
}

output "aks_identity_client_id" {
  value = module.key_vault.aks_identity_client_id
}
#  This allows the environment to expose the information returned by the module