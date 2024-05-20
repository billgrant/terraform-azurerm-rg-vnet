# This is the main file that will be used to call the module

# Required provider block for NO-CODE module
provider "azurerm" {
  features {}
}

module "resource_group_vnet" {
  source    = "./modules/rgvnet"
  vnet_cidr = var.vnet_cidr
}