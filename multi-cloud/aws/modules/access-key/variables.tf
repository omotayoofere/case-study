variable "ec2_access_key" {
  description = "Public key used in creating EC2"
  type = string
  default = "ec2.key"
}

variable "ec2_access_key_filepath" {
  description = "File path to public key"
  type = string
}