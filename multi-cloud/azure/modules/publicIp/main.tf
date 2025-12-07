resource "azurerm_public_ip" "public_ip" {
  name                = var.ip_name
  location            = var.rg_region
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}