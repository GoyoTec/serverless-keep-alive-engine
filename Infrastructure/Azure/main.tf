terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.97.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}

resource "azurerm_resource_group" "member-rg-dev-usw2" {
  name     = "member-rg-dev-usw2"
  location = "West US 2"
  tags = {
    availability = "business"
    business     = "us"
    env          = "dev"
    product      = "membership"
    startdate    = "20211213"
  }

}

resource "azurerm_app_service_plan" "terraform-serviceplan-test" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.member-rg-dev-usw2.location
  resource_group_name = azurerm_resource_group.member-rg-dev-usw2.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "example-app-service-terraform"
  location            = azurerm_resource_group.member-rg-dev-usw2.location
  resource_group_name = azurerm_resource_group.member-rg-dev-usw2.name
  app_service_plan_id = azurerm_app_service_plan.terraform-serviceplan-test.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
