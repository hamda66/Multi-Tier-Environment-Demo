# This file contains the variable definitions for the Terraform configuration.

//Output for location & resource group
location = "southuk"
resource_grp_name = "rg"

//Main Vnet variables
Vnet = "MainVnet"
Vnet_address = [ "10.0.0.0/16" ]

//Subnets
web_sub_name = "Web-subnet"
web_sub_address = [ "10.1.0.0/24" ]

app_sub_name = "Application-Subnet"
app_sub_address = [ "10.2.0.0/24" ]

db_sub_name = "Database-Subnet"
db_sub_address = [ "10.3.0.0/24" ]