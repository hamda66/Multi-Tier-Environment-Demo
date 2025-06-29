resource "azurerm_virtual_network" "MainVnet" {
  name = var.Vnet
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
 
 address_space = var.Vnet_address

}