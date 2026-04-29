terraform {
    required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.100"
    }
  }
  
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "main" {
    name = "learning-iac"
    location = var.locat
}

resource "azurerm_virtual_network" "main" {
    name = "vnet-learning-iac"
    address_space = ["10.0.0.0/16"]
    location = var.locat
    resource_group_name = var.rg
}

resource "azurerm_subnet" "internal" {
    name = "internal"
    virtual_network_name = var.vnet
    resource_group_name = var.rg
    address_prefixes = ["10.0.1.0/24"]
}


resource "azurerm_network_interface" "main" {
  name =  "${var.vm}-nic"
  location = var.locat
  resource_group_name = var.rg

  ip_configuration {
    name                          = "${var.vm}-ipconf"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
    name = "${var.vm}01"
    location = var.locat
    resource_group_name = var.rg
    network_interface_ids = [azurerm_network_interface.main.id]
    vm_size = "Standard_D2s_v3"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
    storage_os_disk {
        name              = "myosdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
        computer_name  = "hostname"
        admin_username = "adminuser"
        admin_password = var.admin_password
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
    tags = {
        environment = "staging"
    }
}