variable "cluster_name" {
  description = "Name of the cluster"
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

variable "vnet_addr_space" {
  description = "Address space of VNET"
  type = list(string)
}

variable "tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}

