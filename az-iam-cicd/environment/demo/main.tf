resource "azuread_application" "github" {
  display_name = "github-actions-app"
}

resource "azuread_service_principal" "github" {
  client_id = azuread_application.github.client_id
}

resource "azuread_application_federated_identity_credential" "github_prod" {
  application_id = azuread_application.github.id
  display_name   = "github-actions-demo"
  description    = "Authentification OIDC GitHub Actions pour l'environnement demo"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"

  subject = "repo:Koretada/terraform-projects/:environment:demo"
}

resource "azurerm_role_assignment" "github_contributor" {
  scope                = "/subscriptions/${var.subscription}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.github.object_id
}
