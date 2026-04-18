# resource "azurerm_resource_group" "rg1" {
# count = 1
# name = "rg1-${count.index}"
# location = "central india"
# }

# variable "names" {
#   default = ["aam", "impli", "angoor"]
# }

# resource "azurerm_resource_group" "fruits" {
#   count    = length(var.names)
#   name     = var.names[count.index]
#   location = "Central India"
# }

# Foreach
variable "rg_names" {}
resource "azurerm_resource_group" "rgs11" {
 for_each = var.rg_names
# "rg1" = "West Europe"
# "rg2" = "Central India"
# "rg3" = "Canada Central"
# "rg4" = "East US"
 name = each.key
 location = each.value
}