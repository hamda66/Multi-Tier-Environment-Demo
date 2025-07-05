resource "azurerm_storage_account" "web-storage" {
    name = "WebStorageAccount"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    access_tier = "Hot"
}

resource "azurerm_storage_account_static_website" "web_static_website" {
    storage_account_id = azurerm_storage_account.web-storage.id
    index_document     = "index.html"
    error_404_document = "404.html"
}

resource "azurerm_storage_container" "httpd_container" {
    name = "httpd-container"
    storage_account_id = azurerm_storage_account.web-storage.id
    container_access_type = "private"
  
}
