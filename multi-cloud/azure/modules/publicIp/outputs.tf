output "worker_node_nat_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "worker_node_nat_ip_id" {
  value = azurerm_public_ip.public_ip.id
}

