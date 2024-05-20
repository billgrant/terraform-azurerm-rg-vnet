output "resource_group_name" {
    value = azurerm_resource_group.webservers_rg.name
}

output "vnet_name" {
    value = azurerm_virtual_network.webservers_network.name
}

output "vnet_address_space" {
    value = azurerm_virtual_network.webservers_network.address_space
  
}

output "subnet_name" {
    value = azurerm_subnet.webserver_subnet.name
}

output "subnet_address_prefix" {
    value = azurerm_subnet.webserver_subnet.address_prefixes  
}