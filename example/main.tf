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
    

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = module.res_group.resource_group_name
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["10.0.2.0/24"]
}
   

resource "azurerm_network_interface" "main" {
  name                = "my-nic"
  location            = module.res_group.resource_group_location
  resource_group_name = module.res_group.resource_group_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "my-vm"
  location              = module.res_group.resource_group_location
  resource_group_name   = module.res_group.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

