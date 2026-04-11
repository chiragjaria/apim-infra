resource "azurerm_api_management_product" "product" {
  product_id          = "order-product"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg.name

  display_name          = "Order Product"
  subscription_required = true
  published             = true
}

resource "azurerm_api_management_product_api" "link_api" {
  api_name            = azurerm_api_management_api.order_api.name
  product_id          = azurerm_api_management_product.product.product_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg.name
}
