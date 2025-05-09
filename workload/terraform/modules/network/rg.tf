resource "azurerm_resource_group" "net" {
  name     = "rg-avd-${substr(var.avdLocation, 0, 5)}-${var.prefix}-${var.rg_network}"
  location = var.avdLocation
}

resource "azurerm_resource_group" "hub_net" {
  name     = "vnethub-uksouth"
  location = var.avdLocation
}

resource "azurerm_resource_group" "ide_net" {
  name     = "infra-rg"
  location = var.avdLocation
}
