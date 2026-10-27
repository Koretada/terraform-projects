# compute

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.image](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Nombre souhaité d'instances au démarrage | `number` | `2` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type d'instance EC2 | `string` | `"t3.small"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Nombre maximal d'instances | `number` | `4` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Nombre minimal d'instances | `number` | `2` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Préfixe de nom pour les ressources | `string` | `"app"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Liste des Security Groups à associer aux instances | `list(string)` | `[]` | no |
| <a name="input_security_group_ids_ec2"></a> [security\_group\_ids\_ec2](#input\_security\_group\_ids\_ec2) | ID des security group pour les EC2 | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Liste des IDs de sous-réseaux où déployer les instances EC2 | `list(string)` | n/a | yes |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | ARNs des Target Groups de l'ALB pour le health check ELB | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_asg_arn"></a> [asg\_arn](#output\_asg\_arn) | ARN de l'Autoscaling Group |
| <a name="output_asg_id"></a> [asg\_id](#output\_asg\_id) | ID de l'Autoscaling Group |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | ID du Launch Template créé |
<!-- END_TF_DOCS -->
