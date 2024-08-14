terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.115.0"
    }
  }

  # backend "azurerm" {
  #   # intentionally blank
  # }
}

provider "azurerm" {
  # subscription_id = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" # Storage Account Subscription
  features {}
}
