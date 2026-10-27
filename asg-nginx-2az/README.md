---
Ceci est un projet de déploiement d'une stack web modulaire et multi-az (VPC / ALB / ASG).

Schéma de l'infrastructure :

![](/asg-nginx-2az/archi_terraform_alb_asg_nginx.png)

#### **1. Partie Réseau (VPC)**
- [x] Créer un VPC réparti sur **2 zones de disponibilité (AZ)**.
- [x] Définir les sous-réseaux : 2 subnets publics et 2 subnets privés.
- [x] Configurer une NAT Gateway.

#### **2. Partie Sécurité (Security Groups)**
- [x] Créer le Security Group de l'ALB (autoriser le trafic entrant HTTP/80 depuis Internet `0.0.0.0/0`).
- [x] Créer le Security Group des instances EC2 (autoriser le trafic HTTP **strictement restreint** à la source du SG de l'ALB).

#### **3. Module Compute (Launch Template & ASG)**
- [x] Rédiger le script `user-data` pour l'installation et le démarrage de Nginx.
- [x] Utiliser la fonction **`templatefile`** pour injecter dynamiquement les variables d'environnement dans le `user-data`.
- [x] Créer le Launch Template configuré sur une architecture AMD.
- [x] Configurer l'Auto Scaling Group (ASG) associé au Launch Template et réparti sur les 2 AZs.

#### **4. Partie Load Balancing & Routage (ALB)**
- [x] Déployer l'Application Load Balancer (ALB) sur les subnets publics.
- [x] Configurer le Target Group (Health Checks Nginx) et l'associer à l'ASG.
- [x] Créer le Listener HTTP pour router le trafic de l'ALB vers le Target Group.

#### **5. Validation & Tests (Definition of Done)**
- [x] Vérifier que la page Nginx répond correctement via le nom DNS public de l'ALB.
- [x] Valider l'étanchéité réseau (les instances ne doivent pas être joignables en direct depuis l'extérieur).
- [x] Vérifier le temps de déploiement / destruction complet du code IaC (**cible : 3 à 4 min**).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.16.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.67.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_compute"></a> [compute](#module\_compute) | ./module/compute | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_alb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_target_group.nginx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_nat_gateway.ng](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.rt_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.rt_asso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rt_association_ng](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.allow_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.elb_allow_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.elb_allow_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.main_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.main_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
