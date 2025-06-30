
//web app subnet NSG
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${var.web_sub_name}-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

// Web app NSG rules

locals {
  webb_ports ={
 # key : value  
  "100" : "80",
 "110" : "443",
  "120" : "8080",  
}
}

resource "azurerm_network_security_rule" "web_subnet_nsg_rule" {
    for_each = local.webb_ports
  name                        = "web-subnet-nsg-rule-${each.key}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = azurerm_subnet.web_subnet.address_prefixes[0]
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}

// Associate the NSG with the web subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

// App subnet NSG