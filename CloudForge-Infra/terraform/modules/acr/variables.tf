variable "resource_group_name" {
    description = "Name of the Resource Group"
    type        = string
}

variable "location" {
    description = "Azure region"
    type        = string
}

variable "acr_name" {
    description = "Name of the Azure Container Registry"
    type        = string
}