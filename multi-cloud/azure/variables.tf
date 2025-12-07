variable "cluster_name" {
  description = "Name of the cluster"
  type = string
}

variable "azure_sub_id" {
  description = "ID of azure subscription"
  type = string
}

variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "tenant_id" {
  description = "ID of the tenant"
  type = string
}

# variable "rg_id" {
#   description = "Id of resource group"
#   type = string
# }

variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "vnet_addr_space" {
  description = "Address space of VNET"
  type = list(string)
}

variable "public_subnet_addr_space" {
  description = "Address space of public subnet"
  type = list(string)
}

variable "private_subnet_addr_space" {
  description = "Address space of private subnet"
  type = list(string)
}

variable "nat_ip_name" {
  description = "Name of the IP"
  type = string
}

variable "emart_vm_public_ip" {
  description = "Name of the IP"
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

variable "vm_name" {
  description = "Name of VM"
  type = string
}

variable "vm_nic" {
  description = "Name of VM"
  type = string
}

variable "vm2_name" {
  description = "Name of VM"
  type = string
}

variable "vm2_nic" {
  description = "Name of VM"
  type = string
}


variable "vm_public_ip" {
  description = "Name of VM"
  type = string
}

variable "public_subnet_name" {
  description = "Name of VM"
  type = string
}

variable "private_subnet_name" {
  description = "Name of VM"
  type = string
}

variable "common_tags" {
  description = "Common tag for all resources"
  type        = map(string)
  default     = {
      Owner       = "Emart-group"
      Project     = "Emart"
      CSP         = "Azure"
  }
}


