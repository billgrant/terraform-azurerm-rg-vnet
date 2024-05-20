#TERRAFORM-AZURERM-RG-VNET

This module creates a Resource Group in Azure with a Vnet and a single subnet.

The module is for HCP Terraform demo/lab purposes. The module is designed for the HCP Terraform private registry. The main/parent module is only used for No-Code deployments. The submodule `rgvnet` should be used for all other run types.

There is a single variable that accepts the Vnet CIDR.
