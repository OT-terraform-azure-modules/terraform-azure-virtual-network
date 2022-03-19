terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.59.0"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
}

module "res_group" {
  source                  = "git@github.com:OT-terraform-azure-modules/terraform-azure-resource-group.git"
  resource_group_name     = "test-rg"
  resource_group_location = "West Europe"
  lock_level_value        = ""
  tag_map = {
    Name = "AzureRG"
  }
}

module "vnet" {
  source                  = "../"
  vnet_name               = "myvnet"
  resource_group_name     = module.res_group.resource_group_name
  resource_group_location = module.res_group.resource_group_location
  address_space           = ["10.0.0.0/16"]
  # create_ddos_protection_plan = true    # Only use this variable when we want Ddos Protection enabled for our VNET. 
  dns_servers             = ["10.0.0.4", "10.0.0.5"]
  tag_map = {
    Owner = "Akanksha"
  }
}

