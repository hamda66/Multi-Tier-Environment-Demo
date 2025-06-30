resource "azurerm_public_ip" "public_ip" {
    name                = "pip-webapp-${var.resource_grp_name}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
    
    tags = {
        environment = "dev"
    }
}