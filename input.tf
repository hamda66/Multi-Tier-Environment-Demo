variable "resource_grp_name" {
  description = "resouce group name"
  type = string
}

variable "location" {
description = "Location info"
type = string
}

variable "Vnet" {
  description = "value for azurerm_virtual_network"
  type = string
}

variable "Vnet_address" {
  description = "Address space for the virtual network"
  type = list(string)
  
}

variable "web_sub_name" {
  description = "Name of the web subnet"
  type = string
  default = "web-subnet"
}

variable "app_sub_name" {
  description = "Name of the app subnet"
  type = string
  default = "app-subnet"
}
variable "db_sub_name" {
  description = "Name of the db subnet"
  type = string
  default = "db-subnet"
}

variable "web_sub_address" {
  description = "Address prefixes for the web subnet"
  type = list(string)
}

variable "app_sub_address" {
  description = "Address prefixes for the app subnet"
  type = list(string)
  
}

variable "db_sub_address" {
  description = "Address prefixes for the db subnet"
  type = list(string)
}
