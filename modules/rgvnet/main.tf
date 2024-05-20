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
