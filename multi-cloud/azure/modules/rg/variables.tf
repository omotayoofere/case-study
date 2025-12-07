variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "rg_region" {
  description = "Region of resource group"
  type = string
  default = "eastus"
}

variable "cluster_name" {
  description = "Name of the cluster"
  type = string
}

variable "tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}