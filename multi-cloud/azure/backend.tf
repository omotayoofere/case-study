terraform {
  backend "azurerm" {
    resource_group_name = "rg-tfstate"
    storage_account_name = "emartstorageaccount201"
    container_name = "emartstoragecontainer201"
    key = "terraform.tfstate"
  }
}