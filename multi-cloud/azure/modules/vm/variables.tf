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

variable "vm_name" {
  description = "Name of VM"
  type = string
}

variable "vm_nic" {
  description = "Name of VM"
  type = string
}

variable "subnet_id" {
  description = "Id of private subnet"
  type = string
}

variable "public_ip" {
  type        = string
  description = "Public IP resource id (optional)"
  default     = null
}

variable "tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}
