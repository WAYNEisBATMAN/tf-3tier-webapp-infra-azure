#---------------------------------------------------
# Virtual Network
#---------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
}

#---------------------------------------------------
# Subnets
#---------------------------------------------------
resource "azurerm_subnet" "subnet" {
  count               = length(var.subnet_prefixes)
  name                = "subnet-${count.index + 1}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[count.index]]
}

#---------------------------------------------------
# Network Security Group
#---------------------------------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = {
      ssh  = var.allow_ssh
      http = var.allow_http
    }
    content {
      name                       = upper(security_rule.key) 
      priority                   = security_rule.key == "ssh" ? 100 : 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.key == "ssh" ? "22" : "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
