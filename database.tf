resource "azurerm_mysql_server" "Sql_server" {
  name                = "SQL-server"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  version             = "8.0"
  administrator_login = "mysqladmin"
  administrator_login_password = "P@ssw0rd1234"

  sku {
    name     = "GP_Gen5_2"
    tier     = "GeneralPurpose"
    capacity = 2
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 51200
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  tags = {
    environment = "Production"
    project     = "MyProject"
  }
}

resource "azurerm_mysql_database" "SQL_database" {
  name = "SQL-database"
  Location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  Server_id = azurerm_mysql_server.Sql_server.Server_id
}