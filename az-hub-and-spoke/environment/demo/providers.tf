terraform {
  required_version = "1.16.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.11.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "az-hub-and-spoke"
    storage_account_name = "statfhubandspoke"
    container_name       = "tfstate"
    key                  = "demo.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
