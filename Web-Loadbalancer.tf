resource "azurerm_lb" "web_load_balancer" {
  name                = "lb-webapp-${var.resource_grp_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  tags = {
    environment = "dev"
  }
  
}

resource "azurerm_lb_probe" "web_load_balancer_probe" {
  name = "webapp-probe"
  loadbalancer_id = azurerm_lb.web_load_balancer.id
    protocol = "Tcp"
    port = 80
   // resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_lb_backend_address_pool" "web_load_balancer_backend" {
  name                = "webapp-backend-pool"
  loadbalancer_id     = azurerm_lb.web_load_balancer.id
  //resource_group_name = azurerm_resource_group.rg.name
  
}

resource "azurerm_lb_rule" "web_load_balancer_rule" {
  name                           = "webapp-rule"
  loadbalancer_id                = azurerm_lb.web_load_balancer.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.web_load_balancer.frontend_ip_configuration[0].name
  backend_address_pool_ids = azurerm_lb_backend_address_pool.web_load_balancer_backend[0].id
  probe_id                       = azurerm_lb_probe.web_load_balancer_probe.id
 
}

/// Load balancer associated with the web subnet
/*
resource "azurerm_network_interface_backend_address_pool_association" "web_subnet_association" {
  count = length(azurerm_network_interface.web_subnet_nic)
  network_interface_id = azurerm_network_interface.web_subnet_nic[count.index].id
  ip_configuration_name = "ipconfig1" //IP configuration name in the NIC  # This should match the name of the IP configuration in the NIC
 
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_load_balancer_backend.id
}
*/