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

variable "public_subnet_id" {
  description = "Id of public subnet"
  type = string
}

variable "sec_rules" {
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = optional(string, "Inbound")
    access                     = optional(string, "Deny")
    protocol                   = optional(string, "*")
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string, "*")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")  
  }))
}

variable "tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}