#######################################
# Modules
#######################################

module "hub" {
  source                         = "../../modules/hub"
  rg_name                        = var.rg_name
  hub_vnet_cidr                  = "10.0.0.0/16"
  hub_azure_firewall_subnet_cidr = "10.0.1.0/24"
  hub_azure_bastion_subnet_cidr  = "10.0.2.0/24"
  location                       = var.location
}

module "spoke_prod" {
  source              = "../../modules/spoke"
  vnet_cidr           = "10.1.0.0/16"
  rg_name             = var.rg_name
  subnet_cidr         = "10.1.1.0/24"
  location            = var.location
  firewall_private_ip = module.hub.firewall_private_ip
  spoke_name          = "production"
}

module "spoke_dev" {
  source              = "../../modules/spoke"
  vnet_cidr           = "10.2.0.0/16"
  rg_name             = var.rg_name
  subnet_cidr         = "10.2.1.0/24"
  location            = var.location
  firewall_private_ip = module.hub.firewall_private_ip
  spoke_name          = "dev"
}

#######################################
# VPC Peering
#######################################

resource "azurerm_virtual_network_peering" "spoke_prod_to_hub" {
  name                         = "vt-peering-prod-to-hub"
  virtual_network_name         = module.spoke_prod.vnet_name
  remote_virtual_network_id    = module.hub.vnet_id
  resource_group_name          = module.hub.resource_group_name
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "spoke_dev_to_hub" {
  name                         = "vt-peering-dev-to-hub"
  virtual_network_name         = module.spoke_dev.vnet_name
  remote_virtual_network_id    = module.hub.vnet_id
  resource_group_name          = module.hub.resource_group_name
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_prod" {
  name                         = "vt-peering-hub-to-prod"
  virtual_network_name         = module.hub.vnet_name
  remote_virtual_network_id    = module.spoke_prod.vnet_id
  resource_group_name          = module.hub.resource_group_name
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_dev" {
  name                         = "vt-peering-hub-to-dev"
  virtual_network_name         = module.hub.vnet_name
  remote_virtual_network_id    = module.spoke_dev.vnet_id
  resource_group_name          = module.hub.resource_group_name
  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

#######################################
# VM PROD
#######################################

resource "azurerm_network_interface" "prod" {
  name                = "nic-prod"
  location            = var.location
  resource_group_name = module.hub.resource_group_name
  ip_configuration {
    name                          = "configuration"
    subnet_id                     = module.spoke_prod.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.1.4"
  }
}

resource "azurerm_linux_virtual_machine" "prod" {
  name                = "machine-prod"
  location            = var.location
  resource_group_name = module.hub.resource_group_name
  size                = var.vm_size
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  network_interface_ids = [azurerm_network_interface.prod.id]
  admin_username        = "sysadmin"
  admin_ssh_key {
    username   = "sysadmin"
    public_key = file("~/.ssh/id_ed25519.pub")
  }
}

resource "azurerm_network_security_group" "prod" {
  name                = "nsg-prod"
  location            = var.location
  resource_group_name = module.hub.resource_group_name
}

resource "azurerm_network_interface_security_group_association" "prod" {
  network_interface_id      = azurerm_network_interface.prod.id
  network_security_group_id = azurerm_network_security_group.prod.id
}
#######################################
# VM DEV
#######################################

resource "azurerm_network_interface" "dev" {
  name                = "nic-dev"
  location            = var.location
  resource_group_name = module.hub.resource_group_name
  ip_configuration {
    name                          = "configuration"
    subnet_id                     = module.spoke_dev.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.2.1.4"
  }
}

resource "azurerm_linux_virtual_machine" "dev" {
  name                = "machine-dev"
  location            = var.location
  resource_group_name = module.hub.resource_group_name
  size                = var.vm_size
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  network_interface_ids = [azurerm_network_interface.dev.id]
  admin_username        = "sysadmin"
  admin_ssh_key {
    username   = "sysadmin"
    public_key = file("~/.ssh/id_ed25519.pub")
  }
}


resource "azurerm_network_security_group" "dev" {
  name                = "nsg-dev"
  location            = var.location
  resource_group_name = module.hub.resource_group_name
}

resource "azurerm_network_interface_security_group_association" "dev" {
  network_interface_id      = azurerm_network_interface.dev.id
  network_security_group_id = azurerm_network_security_group.dev.id
}
