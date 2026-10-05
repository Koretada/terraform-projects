variable "name_prefix" {
  description = "Préfixe de nom pour les ressources"
  type        = string
  default     = "app"
}

variable "subnet_ids" {
  description = "Liste des IDs de sous-réseaux où déployer les instances EC2"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Liste des Security Groups à associer aux instances"
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.small"
}

variable "min_size" {
  description = "Nombre minimal d'instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Nombre maximal d'instances"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Nombre souhaité d'instances au démarrage"
  type        = number
  default     = 2
}

variable "target_group_arns" {
  description = "ARNs des Target Groups de l'ALB pour le health check ELB"
  type        = list(string)
  default     = []
}

variable "security_group_ids_ec2" {
  description = "ID des security group pour les EC2"
  type        = list(string)
}