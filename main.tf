resource "azurerm_network_ddos_protection_plan" "ddos" {
  count               = var.create_ddos_protection_plan ? 1 : 0
  name                = "${var.vnet_name}-ddos"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tag_map

  dynamic "ddos_protection_plan" {
    for_each = local.if_ddos_enabled

    content {
      id     = azurerm_network_ddos_protection_plan.ddos[0].id
      enable = true
    }
  }

}
