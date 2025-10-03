#---------------------------------------------------
# Network Interface for each VM
#---------------------------------------------------
resource "azurerm_network_interface" "web_nic" {
  count               = var.instance_count
  name                = "web-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[count.index % length(var.subnet_ids)]
    private_ip_address_allocation = "Dynamic"
  }

}

#---------------------------------------------------
# Associate NSG with NIC
#---------------------------------------------------
resource "azurerm_network_interface_security_group_association" "web_nic_nsg" {
  count                     = var.instance_count
  network_interface_id      = azurerm_network_interface.web_nic[count.index].id
  network_security_group_id = var.nsg_id
}

#---------------------------------------------------
# Linux Virtual Machines
#---------------------------------------------------
resource "azurerm_linux_virtual_machine" "web" {
  count               = var.instance_count
  name                = "web-server-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.web_nic[count.index].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    Subnet = "subnet-${count.index % length(var.subnet_ids) + 1}"
  }
}

#---------------------------------------------------
# Public IP for Load Balancer
#---------------------------------------------------
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#---------------------------------------------------
# Azure Load Balancer
#---------------------------------------------------
resource "azurerm_lb" "app_lb" {
  name                = "app-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

#---------------------------------------------------
# Backend Pool
#---------------------------------------------------
resource "azurerm_lb_backend_address_pool" "web_bap" {
  name            = "web-bap"
  loadbalancer_id = azurerm_lb.app_lb.id
}

#---------------------------------------------------
# Load Balancer Rule
#---------------------------------------------------
resource "azurerm_lb_rule" "http" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.app_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.app_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_bap.id]
}
