variable "subnet_name" {
  description = "Name of subnet"
  type = string
}

variable "vnet_name" {
  description = "Name of vnet"
  type = string
}

variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "nat_public_ip" {
  description = "Public IP of NAT gateway"
  type = string
}

variable "subnet_id" {
  description = "ID of subnet"
  type = string
}

variable "tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}
