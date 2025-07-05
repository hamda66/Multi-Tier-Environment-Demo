# NAT Gateway fr App teir subnet

resource "azurerm_public_ip" "nat_pip" {
  name                = "nat-gw-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = "nat-gateway"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gw_pip_association" {
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gw_subnet_association" {
  subnet_id      = azurerm_subnet.app_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
  
}