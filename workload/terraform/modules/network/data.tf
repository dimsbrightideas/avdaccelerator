data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azurerm_virtual_network" "remote" {
  provider            = azurerm.hub
  name                = var.hub_vnet
  resource_group_name = var.hub_connectivity_rg
  depends_on          = [azurerm_virtual_network.hub_vnet]
}

data "azurerm_virtual_network" "identity" {
  provider            = azurerm.identity
  name                = var.identity_vnet
  resource_group_name = var.identity_rg
  depends_on          = [azurerm_virtual_network.ide_vnet]
}
