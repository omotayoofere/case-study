variable "subnet_addr_space" {
  description = "Address space of public subnet"
  type = list(string)
}

variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "subnet_name" {
  description = "Name of subnet"
  type = string
}

variable "vnet_name" {
  description = "Name of vnet"
  type = string
}