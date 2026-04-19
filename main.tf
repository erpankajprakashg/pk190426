variable "rg_names" {
  
}
resource "azurerm_resource_group" "rg1904" {
  for_each = var.rg_names
  name = each.key
  location = each.value
}