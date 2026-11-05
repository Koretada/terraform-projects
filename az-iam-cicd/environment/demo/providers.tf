terraform {
  required_version = "1.17.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.12.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "az-github-iam"
    storage_account_name = "stgithubiam"
    subscription_id      = "ab597d7a-c22d-409e-844e-83954fcdeccf"
    container_name       = "tfstate"
    key                  = "demo.terraform.tfsate"
    use_azuread_auth     = true
  }
}
provider "azurerm" {
  features {

  }
}
