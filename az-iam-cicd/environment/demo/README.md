# demo

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.17.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 5.12.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.10.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 5.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_application.github](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.github_prod](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_service_principal.github](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.github_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/5.12.0/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_subscription"></a> [subscription](#input\_subscription) | Identifiant de la subscription. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
