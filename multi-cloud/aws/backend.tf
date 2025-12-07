# terraform {
#   backend "s3" {
#     bucket   = "emart-iac-state-storage"
#     key      = "emart/my-statefile/terraform.tfstate"
#     region   = "us-east-1"
#     encrypt = true
#   }

#   required_version = ">= 1.12.2"
# }