output "nat_name" {
  value = azurerm_nat_gateway.nat_gw.name
}

output "nat_id" {
  value = azurerm_nat_gateway_public_ip_association.nat_pip_association.id
}