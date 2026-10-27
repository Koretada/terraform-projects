variable "spoke_name" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "firewall_private_ip" {
  type        = string
  description = "Ip du firewall"
}
