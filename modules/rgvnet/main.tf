# Provider configuration
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

# Random ID for resource naming
resource "random_id" "webservers_id" {
  byte_length = 8
}

# Create Resource Group
resource "azurerm_resource_group" "webservers_rg" {
  name     = "webservers-${random_id.webservers_id.hex}"
  location = "East US"
}

# Create Azure VNET
resource "azurerm_virtual_network" "webservers_network" {
  name                = "webserver-network-${random_id.webservers_id.hex}"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.webservers_rg.location
  resource_group_name = azurerm_resource_group.webservers_rg.name
}

# Create Subnets for webservers
resource "azurerm_subnet" "webserver_subnet" {
  name                 = "webserver-subnet-${random_id.webservers_id.hex}"
  resource_group_name  = azurerm_resource_group.webservers_rg.name
  virtual_network_name = azurerm_virtual_network.webservers_network.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 8, 0)]
}

# Security group to allow inbound webtraffic
resource "azurerm_network_security_group" "webserver-sg" {
  name                = "webserver-sg-${random_id.webservers_id.hex}"
  location            = azurerm_resource_group.webservers_rg.location
  resource_group_name = azurerm_resource_group.webservers_rg.name

  security_rule {
    name                       = "webserver-sg-rule-${random_id.webservers_id.hex}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Subnet/Security Group assocication
resource "azurerm_subnet_network_security_group_association" "webserver-sg-association" {
  subnet_id                 = azurerm_subnet.webserver_subnet.id
  network_security_group_id = azurerm_network_security_group.webserver-sg.id
}