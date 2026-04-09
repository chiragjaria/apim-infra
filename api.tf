resource "azurerm_api_management_api" "order_api" {
  name                = "order-api"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Order API"
  path                = "orders"
  protocols           = ["https"]

  service_url = var.function_app_url
}

resource "azurerm_api_management_api_operation" "create_order" {
  operation_id        = "create-order"
  api_name            = azurerm_api_management_api.order_api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name

  display_name = "Create Order"
  method       = "POST"
  url_template = "/"
}

resource "azurerm_api_management_api_policy" "policy" {
  api_name            = azurerm_api_management_api.order_api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name

  xml_content = file("${path.module}/policy.xml")
}
