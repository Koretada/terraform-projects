#######################################
# Networking
#######################################

resource "azurerm_virtual_network" "spoke" {
  name                = "azure-vnet-${var.spoke_name}"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "spoke" {
  name                 = "azure-subnet-${var.spoke_name}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.subnet_cidr]
}

resource "azurerm_route_table" "spoke" {
  name                = "azure-rt-${var.spoke_name}"
  location            = var.location
  resource_group_name = var.rg_name
  route {
    name                   = "default-to-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_in_ip_address = var.firewall_private_ip
    next_hop_type          = "VirtualAppliance"
  }
}

resource "azurerm_subnet_route_table_association" "spoke" {
  subnet_id      = azurerm_subnet.spoke.id
  route_table_id = azurerm_route_table.spoke.id
}
