
##   Since this is an internal Load Balancer, we do not need to specify a public IP address.

resource "azurerm_lb" "app_lb" {
  name = "app-lb"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = "Standard"

  frontend_ip_configuration {
    name = "app-lb-frontend"
    subnet_id = azurerm_subnet.app_subnet.id
    private_ip_address = "10.1.11.241" # Proxy IP for the app subnet
    private_ip_address_allocation = "Static"
    private_ip_address_version = "IPv4"
  }

}

resource "azurerm_lb_probe" "app_lb_probe" {
  name = "app-lb-probe"
  loadbalancer_id = azurerm_lb.app_lb.id
  protocol = "Tcp"
  port = 80
  
}

resource "azurerm_lb_backend_address_pool" "app_lb_backend" {
  name = "app-lb-backend"
  loadbalancer_id = azurerm_lb.app_lb.id
  
}

resource "azurerm_lb_rule" "app_lb_rule" {
  name = "app-lb-rule"
  loadbalancer_id = azurerm_lb.app_lb.id
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.app_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.app_lb_backend.id]
  probe_id = azurerm_lb_probe.app_lb_probe.id
  
}