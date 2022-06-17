terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "2.23.0"
    }
  }
}

provider "azuread" {
    tenant_id = ""
  # Configuration options
}

data "azuread_application_template" "example" {
  display_name = "AWS Single-Account Access"
}

resource "azuread_application" "example" {
  display_name = "arhoten-tf-test"
  template_id  = data.azuread_application_template.example.template_id
  identifier_uris   = ["https://signin.aws.amazon.com/saml#123456"]
    web { 
   redirect_uris = ["https://signin.aws.amazon.com/saml"]
   }
  
}

resource "azuread_service_principal" "example" {
  application_id = azuread_application.example.application_id
  use_existing   = true
  preferred_single_sign_on_mode = "saml"
  app_role_assignment_required  = false
