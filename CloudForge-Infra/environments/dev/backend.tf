terraform {
  backend "azurerm" {
    resource_group_name  = "cloudforge-dev-rg"
    storage_account_name = "cloudforgestatedev001"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

# Terraform will store the dev enviroment's state in Azure instead of your local machine