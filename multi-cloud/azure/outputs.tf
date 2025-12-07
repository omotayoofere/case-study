output "rg_id" {
  value = module.azure-rg.rg_id
}

output "rg_name" {
  value = module.azure-rg.rg_name
}

output "rg_region" {
  value = module.azure-rg.rg_region
}

# output "vnet_id" {
#   value = module.cluster-vnet.vnet_id
# }

# output "public_subnet_id" {
#   value = module.public_subnet.subnet_id
# }

# output "private_subnet_id" {
#   value = module.private_subnet.subnet_id
# }

# output "worker_node_nat_ip_id" {
#   value = module.natgw_public_ip.worker_node_nat_ip_id
# }

# output "worker_node_nat_ip" {
#   value = module.natgw_public_ip.worker_node_nat_ip
# }

# output "worker_node_nat" {
#   value = module.cluster-vnet.worker_node_nat
# }
