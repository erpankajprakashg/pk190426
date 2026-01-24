resource "azurerm_resource_group" "rgpk" {
  name     = "rg_Pankaj"
  location = "centralindia"
}

resource "azurerm_virtual_network" "vnet" {
    depends_on = [ azurerm_resource_group.rgpk ]
  name                = "vnetpk"
  address_space       = ["10.0.0.0/16"]
  location            = "centralindia"
  resource_group_name = "rg_Pankaj"
}

resource "azurerm_subnet" "subnetpk" {
    depends_on = [ azurerm_resource_group.rgpk , azurerm_virtual_network.vnet ]
  name                 = "subnetpk"
  resource_group_name  = "rg_Pankaj"
  virtual_network_name = "vnetpk"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip" {
    depends_on = [ azurerm_resource_group.rgpk ]
  name                = "pippk"
  resource_group_name = "rg_Pankaj"
  location            = "centralindia"
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "nic" {
    depends_on = [ azurerm_resource_group.rgpk ]
  name                = "nicpk"
  location            = "centralindia"
  resource_group_name = "rg_Pankaj"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetpk.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
    depends_on = [ azurerm_resource_group.rgpk ]
  name                = "vmpk"
  resource_group_name = "rg_Pankaj"
  location            = "centralindia"
  size                = "Standard_D2s_v5"
  admin_username      = "adminuser"
  admin_password = "Pankaj@12345"
  network_interface_ids = [azurerm_network_interface.nic.id]
  disable_password_authentication = false

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}