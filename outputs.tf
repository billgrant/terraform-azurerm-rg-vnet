output "resource_group_name" {
  value = module.resource_group_vnet.resource_group_name
}

output "resource_group_location" {
  value = module.resource_group_vnet.resource_group_location
}

output "vnet_name" {
  value = module.resource_group_vnet.vnet_name
}

output "vnet_address_space" {
  value = module.resource_group_vnet.vnet_address_space

}
output "subnet_name" {
  value = module.resource_group_vnet.subnet_name
}

output "subnet_id" {
  value = module.resource_group_vnet.subnet_id
}
output "subnet_address_prefix" {
  value = module.resource_group_vnet.subnet_address_prefix
}