resource "azurerm_application_gateway" "web_app_gateway" {
  name                = "web-app-gateway"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.web_subnet.id
  }

  frontend_port {
    name = "appGatewayFrontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = "appGatewayBackendPool"
  }

  backend_http_settings {
    name                  = "appGatewayBackendHttpSettings"
    cookie_based_affinity = "Enabled" // set to enabled if you want to use session persistence based on cookies for applications such as java web applications. Java applications require session persistence to maintain user sessions across multiple requests. Will fail if set to "Disabled"
    port                  = 80
    path = "/*" // Path to the health check endpoint of your application. This is used by the Application Gateway to check the health of the backend servers.
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "appGatewayHttpListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "appGatewayFrontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "appGatewayHttpListener"
    backend_address_pool_name  = "appGatewayBackendPool"
    backend_http_settings_name = "appGatewayBackendHttpSettings"
  }

  tags = {
    environment = "Production"
    project     = "MyProject"
  }
  
}