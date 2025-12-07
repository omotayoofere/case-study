rg_name="emart-resource-rg"
cluster_name="emart-resource-cluster"
rg_region="westus2"
azure_sub_id="bb281e30-cd5c-4513-96a2-ea645adb3c64"
vnet_addr_space=["10.0.0.0/16"]
public_subnet_addr_space=["10.0.0.0/25"]
private_subnet_addr_space=["10.0.0.128/25"]
nat_ip_name="nat_ip_name"
emart_vm_public_ip="emart_vm_public_ip"

sec_rules = {
  ssh = {
    name           = "HTTPs_rule"
    priority       = 100
    direction      = "Inbound"
    access         = "Allow"
    protocol       = "Tcp"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  http = {
    name           = "SSH"
    priority       = 101
    direction      = "Inbound"
    access         = "Allow"
    protocol       = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  deny_all = {
    name           = "k8s_egress"
    priority       = 102
    direction      = "Inbound"
    access         = "Allow"
    protocol       = "Tcp"
    source_port_range = "*"
    destination_port_range = "10250"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

vm_public_ip="public_vm_ip"
public_subnet_name="public_vm_subnet"
private_subnet_name="private_vm_subnet"
vm_name="publicvm"
vm_nic="public_vm_nic"
vm2_name="privatevm"
vm2_nic="private_vm_nic"
tenant_id="8c052fa2-b11b-4526-9f8d-13595118fde8"
admin_username="admin_user"