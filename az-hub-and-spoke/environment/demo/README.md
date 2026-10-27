# demo

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.16.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 5.11.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 5.11.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_hub"></a> [hub](#module\_hub) | ../../modules/hub | n/a |
| <a name="module_spoke_dev"></a> [spoke\_dev](#module\_spoke\_dev) | ../../modules/spoke | n/a |
| <a name="module_spoke_prod"></a> [spoke\_prod](#module\_spoke\_prod) | ../../modules/spoke | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_linux_virtual_machine.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_virtual_network_peering.hub_to_spoke_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.hub_to_spoke_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spoke_dev_to_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.spoke_prod_to_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"Belgium Central"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `string` | `"rg-hub-and-spoke"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | n/a | `string` | `"Standard_D2as_v4"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
