resource "azurerm_resource_group" "rg" {
  name = var.resource_grp_name
  location = var.location
  tags = {
    environment = "dev"
    }
}