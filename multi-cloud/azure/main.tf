provider "azurerm" {
  features {}
  subscription_id = var.SUBSCRIPTION_ID
}

module "azure-rg" {
  source = "./modules/rg"
  rg_name = var.rg_name
  rg_region = var.rg_region
  cluster_name = "${var.cluster_name}-${terraform.workspace}"
  tags = merge(
    local.common_tags
  )
}

module "natgw_public_ip" {
  source = "./modules/publicIp"
  ip_name = var.nat_ip_name
  rg_region = module.azure-rg.rg_region
  rg_name = module.azure-rg.rg_name
  tags = merge(
    local.common_tags
  )
}

module "cluster-vnet" {
  source = "./modules/vnet"
  cluster_name = var.cluster_name
  rg_region = module.azure-rg.rg_region
  vnet_addr_space = var.vnet_addr_space
  rg_name = module.azure-rg.rg_name
  tags = merge(
    local.common_tags
  )
}

module "public_subnet" {
  source = "./modules/subnet"
  rg_name = module.azure-rg.rg_name
  subnet_addr_space = var.public_subnet_addr_space
  subnet_name = var.public_subnet_name
  vnet_name = module.cluster-vnet.vnet_name
}

module "emart-sec-group" {
  source = "./modules/secGroup"
  rg_name = module.azure-rg.rg_name
  rg_region = module.azure-rg.rg_region
  public_subnet_id = module.public_subnet.subnet_id
  cluster_name = var.cluster_name
  sec_rules = var.sec_rules
  tags = merge(
    local.common_tags
  )
}
##this 
module "emart_public_ip" {
  source = "./modules/publicIp"
  ip_name = var.emart_vm_public_ip
  rg_region = module.azure-rg.rg_region
  rg_name = module.azure-rg.rg_name
  tags = merge(
    local.common_tags
  )
}

module "vm_public_ip" {
  source = "./modules/publicIp"
  ip_name = var.vm_public_ip
  rg_region = module.azure-rg.rg_region
  rg_name = module.azure-rg.rg_name
  tags = merge(
    local.common_tags
  )
}

module "private_subnet" {
  source = "./modules/subnet"
  rg_name = module.azure-rg.rg_name
  subnet_addr_space = var.private_subnet_addr_space
  subnet_name = var.private_subnet_name
  vnet_name = module.cluster-vnet.vnet_name
}

module "nat_gateway" {
  source = "./modules/nat"
  rg_name = module.azure-rg.rg_name
  rg_region = module.azure-rg.rg_region
  vnet_name = module.cluster-vnet.vnet_name
  subnet_id = module.private_subnet.subnet_id
  subnet_name = module.public_subnet.subnet_name
  nat_public_ip = module.natgw_public_ip.worker_node_nat_ip_id
  tags = merge(
    local.common_tags
  )
}

module "emart-vm" {
  source = "./modules/vm"
  rg_name = module.azure-rg.rg_name
  rg_region = module.azure-rg.rg_region
  cluster_name = var.cluster_name
  vm_name = var.vm_name
  vm_nic = var.vm_nic
  public_ip = module.vm_public_ip.worker_node_nat_ip_id
  subnet_id = module.public_subnet.subnet_id
  tags = merge(
    local.common_tags
  )
}

module "emart-vm2" {
  source = "./modules/vm"
  rg_name = module.azure-rg.rg_name
  rg_region = module.azure-rg.rg_region
  cluster_name = var.cluster_name
  vm_name = var.vm2_name
  vm_nic = var.vm2_nic
  subnet_id = module.private_subnet.subnet_id
  tags = merge(
    local.common_tags
  )
}