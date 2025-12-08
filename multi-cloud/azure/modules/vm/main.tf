resource "azurerm_network_interface" "nic" {
  name                = var.vm_nic
  location              = var.rg_region
  resource_group_name   = var.rg_name

  tags = var.tags

  ip_configuration {
    name                          = "${var.vm_nic}-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.public_ip != null ? var.public_ip : null
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.rg_region
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  disable_password_authentication = true


  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS" 
  }

  admin_username = var.admin_username

  admin_ssh_key {
    username = var.admin_username
    public_key = var.ssh_key
  }

  tags = var.tags
}