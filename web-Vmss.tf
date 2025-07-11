resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name = "web-vmss"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
   sku = "Standard_DS1_v2"
   instances = 1
    admin_username = var.admin_username
    admin_ssh_key {
        username   = var.admin_username
        public_key = file("${path.module}/ssh_keys/id_rsa.pub")
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts-gen2"
        version   = "latest"
    }   

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    disable_password_authentication = true

    network_interface {
      name = "webb-vmss-nic"
       ip_configuration {
        name                          = "ipconfig1"
        primary                       = true
        subnet_id                     = azurerm_subnet.web_subnet.id

        ##Add web vmms NSG assiociation id here

        load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_load_balancer_backend.id]
        
      }
    }

   ### script for web server. Custom data is used to run a script on the VM at creation time and only accepts base64 encoded data.
   custom_data = filebase64("${path.module}/script/web-script.sh")


    // must be added to ensure the VMSS is created after the database and database network rule to ensure the VMSS can connect to the database  
   depends_on = [ azurerm_mysql_database.SQL_database, azurerm_virtual_network_rule.my_sql_vnet_rule ]

}
