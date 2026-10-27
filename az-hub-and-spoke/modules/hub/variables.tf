variable "hub_vnet_cidr" {
  type        = string
  description = "Plage CIDR pour le VNet Hub"
}

variable "hub_azure_firewall_subnet_cidr" {
  type        = string
  description = "Plage CIDR pour le Hub azure firewall"
}

variable "hub_azure_bastion_subnet_cidr" {
  type        = string
  description = "Plage CIDR pour le Hub azure bastion"
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}
