variable "region_name" {
  description = "Target region for deployment"
  type = string
  default = "us-east-1"
}

variable "k8s-vpc-cidr" {
  description = "CIDR for the k8s-vpc"
  type = string
}

variable "subnet_cidr" {
  description = "Subnet CIDRS"
  type = number
}

variable "public_subnet_count" {
  description = "Count of public subnets to be created"
  type = number
}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
}

variable "private_subnet_count" {
  description = "Count of private subnets to be created"
  type = number
}

variable "common_tags" {
  description = "Common tag for all resources"
  type        = map(string)
  default     = {
      Owner       = "Emart-group"
      Project     = "Emart"
      CSP         = "AWS"
  }
}

# variable "vpc-id" {
#   description = "ID of the VPC to attach security created using this module"
#   type = string
# }

variable "cluster_name" {
  description = "Name of the cluster"
  type = string
}

# variable "sec_groups" {
#   description = "Security group definitions"
#   type    = map(object({
#     allowed_ingress = list(object({
#       type        = string
#       from_port   = number
#       to_port     = number
#       protocol    = string
#       cidr_blocks = optional(list(string), [])     
#     }))
#     subnet_type = string # "public" or "private"
#     appName     = string
#     tags = optional(map(string), {}) 
#   }))
# }

# variable "associate-public-ip" {
#   description = "Associate public IP to the instance"
#   type = list(bool)
# }

variable "access-key-name" {
  description = "Name of access key from access key module"
  type = string
}

variable "ec2_access_key_filepath" {
  description = "File path to public key"
  type = string
}

variable "default_ami_type" {
  description = "AMI of instance"
  type = string
}

variable "default_capacity_type" {
  description = "Capacity type of instancea"
  type = string
}

variable "nat_gateway" {
  type        = bool
  default     = false
  description = "A boolean flag to deploy NAT Gateway."
}

# variable "managed_node_groups" {
#   description = "Map of EKS managed node groups configurations"
#   type = map(object({
#     name           = string
#     desired_size   = number
#     max_size       = number
#     min_size       = number
#     instance_types = list(string)
#   }))
#   default = {}
# }

variable "node_group_name" {
  description = "Name of node group"
  type = string
}

variable "desired_size" {
  description = "desired number of nodes"
  type = number
}

variable "max_size" {
  description = "Max number of nodes there can be"
  type = number
}

variable "min_size" {
  description = "Min number of nodes there can be"
  type = number
}

variable "instance_types" {
  description = "Type of instance"
  type = list(string)
}