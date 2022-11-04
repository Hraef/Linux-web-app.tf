resource "azurerm_resource_group" "app-rg" {
  name     = "app-rg"
  location = "Eastus"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_service_plan" "app-plan" {
  name                = "app001"
  resource_group_name = azurerm_resource_group.app-rg.name
  location            = azurerm_resource_group.app-rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "linux-app" {
  name                = "linux-app-hr"
  resource_group_name = azurerm_resource_group.app-rg.name
  location            = azurerm_service_plan.app-plan.location
  service_plan_id     = azurerm_service_plan.app-plan.id

  site_config {
    always_on = true
    application_stack {
      docker_image = hibryd/nextwebapp
    }
  }
}