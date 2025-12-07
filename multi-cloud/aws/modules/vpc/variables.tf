variable "region_name" {
  description = "Target region for deployment"
  type = string
}

variable "common_tags" {
  description = "Tags common to every resource"
  type = map(string)
}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
}

variable "k8s-vpc-cidr" {
  description = "CIDR for the k8s-vpc"
  type = string
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
}

variable "map_public_ip" {
  type        = bool
  default     = false
  description = "A boolean flag to assign public IPs to resources in a subnet."
}

variable "subnet_cidr" {
  description = "Subnet CIDRS"
  type = number
}

variable "public_subnet_count" {
  description = "Count of public subnets to be created"
  type = number
}

variable "private_subnet_count" {
  description = "Count of private subnets to be created"
  type = number
}

variable "nat_gateway" {
  type        = bool
  default     = false
  description = "A boolean flag to deploy NAT Gateway."
}

variable "public_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all public subnets."
}

variable "private_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all public subnets."
}