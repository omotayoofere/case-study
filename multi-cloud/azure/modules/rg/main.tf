resource "azurerm_resource_group" "rg" {
  name     = "${var.cluster_name}-rg"
  location = var.rg_region

  tags = var.tags
}


