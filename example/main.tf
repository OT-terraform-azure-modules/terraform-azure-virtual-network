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
  source                  = "git::https://github.com/OT-terraform-azure-modules/terraform-azure-resource-group.git?ref=v0.0.1"
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
    Owner = "Akansha"
  }
}

resource "azurerm_linux_virtual_machine" "bad_linux_example" {
  name                            = "bad-linux-machine"
  resource_group_name             = azurerm_resource_group.example.name
  location                        = azurerm_resource_group.example.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "somePassword"
  disable_password_authentication = false
}

resource "azurerm_virtual_machine" "bad_example" {
    name                            = "bad-linux-machine"
    resource_group_name             = azurerm_resource_group.example.name
    location                        = azurerm_resource_group.example.location
    size                            = "Standard_F2"
    admin_username                  = "adminuser"
    admin_password                  = "somePassword"

    os_profile {
        computer_name  = "hostname"
        admin_username = "testadmin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
  }
