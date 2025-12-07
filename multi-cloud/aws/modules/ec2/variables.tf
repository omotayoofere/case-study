variable "instance_type" {
  description = "Type of instance that is being deployed"
  type = string
  default = "t2.micro"
}

variable "access-key-name" {
  description = "Name of access key from access key module"
  type = string
}

variable "subnet-id" {
  description = "ID of subnets from the vpc module"
  type = string
}

variable "tags" {
  description = "Tags common to every resource"
  type = map(string)
}

variable "sg-id" {
  description = "ID of subnets from the vpc module"
  type = string
}

variable "associate-public-ip" {
  description = "Associate public IP to the instance"
  type = bool
}
