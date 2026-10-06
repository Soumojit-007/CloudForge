variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet used by AKS"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the AKS default node pool"
  type        = number
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
}


variable "log_analytics_workspace_id"{
  type = string
}
#  Defines the config values our AKS module needs