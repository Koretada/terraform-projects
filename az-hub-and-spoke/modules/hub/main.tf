resource "azurerm_resource_group" "hub" {
  name     = var.rg_name
  location = var.location
}

#######################################
# Networking
#######################################

resource "azurerm_network_security_group" "hub" {
  name                = "hub-nsg"
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
}

resource "azurerm_virtual_network" "hub" {
  name                = "hub-vnet"
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
  address_space       = [var.hub_vnet_cidr]
}

resource "azurerm_subnet" "az_firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.hub_azure_firewall_subnet_cidr]
}

resource "azurerm_subnet" "az_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.hub_azure_bastion_subnet_cidr]
}

#######################################
# Azure Firewall
#######################################

resource "azurerm_public_ip" "firewall" {
  name                = "az-ip-firewall"
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "hub" {
  name                = "hub-azure-firewall"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.hub.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.az_firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

resource "azurerm_firewall_policy" "hub" {
  name                = "firewall-policy-hub"
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "allow_all_outbound" {
  name               = "rcg-outbound-allow-all"
  firewall_policy_id = azurerm_firewall_policy.hub.id
  priority           = 100

  network_rule_collection {
    name     = "net-collection-allow-all"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "allow-all-outbound"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

#######################################
# Azure Bastion
#######################################

resource "azurerm_public_ip" "bastion" {
  name                = "pip-bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "hub" {
  name                = "hub-azure-bastion"
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.az_bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
