# This is the main file that will be used to call the module

# Requied provider block for NO-CODE module
provider "azurerm" {
  features {}
}

module "resource_group_vnet" {
  source = "./modules/rgvnet"
  vnet_cidr = var.vnet_cidr  
}