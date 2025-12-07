resource "azurerm_nat_gateway" "nat_gw" {
  name                = var.subnet_name
  location            = var.rg_region
  resource_group_name = var.rg_name
  sku_name            = "Standard"

  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = var.nat_public_ip
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
