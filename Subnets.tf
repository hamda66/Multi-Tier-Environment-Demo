
//3 subnet included in this file, Web subnet, App subnet and DB subnet

resource "azurerm_subnet" "web_subnet" {
  name                 = var.web_sub_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.MainVnet.name
  address_prefixes     = var.web_sub_address
}

resource "azurerm_subnet" "app_subnet" {
    name = var.app_sub_name
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.MainVnet.name
    address_prefixes = var.app_sub_address
  
}

resource "azurerm_subnet" "database_subnet" {
  name = var.db_sub_name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.MainVnet.name
  address_prefixes = var.db_sub_address
}