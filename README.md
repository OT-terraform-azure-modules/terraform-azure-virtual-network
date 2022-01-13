Azure Virtual Network Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage]

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates Vnet on Azure.

These types of resources are supported:

* [VNET](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)

Terraform versions
------------------
Terraform 1.0

Usage
------

```hcl
module "res_group" {
  source                  = "git::https://github.com/OT-terraform-azure-modules/azure_resource_group.git"
  resource_group_name     = "_"
  resource_group_location = "_"
  lock_level_value        = ""
  tag_map = {
    Name = "AzureResourceGroup"
  }
}

module "vnet" {
  source        = "git::https://github.com/OT-terraform-azure-modules/terraform-azure-virtual-network.git"
  rg_name       = module.res_group.resource_group_name
  vnet_location = module.res_group.resource_group_location
  address_space = ["_"]
  vnet_name     = ""
  dns_servers   = ["_", "_"]
}

```

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Resources
------
| Name | Type |
|------|------|
| [azurerm_network_ddos_protection_plan.ddos](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan) | resource |
| [azurerm_virtual_network.Vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |


Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vnet_name | The name of the virtual network. Changing this forces a new resource to be created. | `string` |  | Yes |
| resource_group_name | The name of the resource group in which to create the virtual network. | `string` |  | Yes |
| resource_group_location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` |  | yes |
| address_space | The address space that is used the virtual network. You can supply more than one address space. | `list(string)` |  | yes |
| create_ddos_protection_plan | Create an ddos plan - Default is false | `bool` | `false` | No |
| dns_servers | List of IP addresses of DNS servers | `list(string)` |  | No |
| tag_map | Tag to associate with the Resource Group | `map(string)` | | no |

Output
------
| Name | Description |
|------|-------------|
| vnet_id | The id of the newly created Vnet. |
| vnet_name | The Name of the newly created Vnet |
| vnet_location | The location of the newly created Vnet |
| vnet_address_space | The address space of the newly created Vnet |

## Related Projects

Check out these related projects.

### Contributors
|  [![Akanksha Srivastava][Akanksha_avatar]][akanksha.s_homepage]<br/>[Akanksha Sriastava][akanksha.s_homepage] |
|---|
 
  [akanksha.s_homepage]:https://gitlab.com/akanksha.s
  [Akanksha_avatar]: https://gitlab.com/uploads/-/system/user/avatar/8698995/avatar.png?width=400
