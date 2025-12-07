variable "ip_name" {
  description = "Name of the IP"
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

variable "tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}