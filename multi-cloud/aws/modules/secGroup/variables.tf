variable "tags" {
  description = "Tags common to every resource"
  type = map(string)
}

variable "vpc-id" {
  description = "ID of the VPC to attach security created using this module"
  type = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type = string
}