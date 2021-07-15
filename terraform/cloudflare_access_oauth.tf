resource "cloudflare_access_identity_provider" "gsuite" {
  account_id = var.cloudflare_account_id
  name       = "GSuite"
  type       = "google-apps"
  config {
    client_id     = var.gsuite_client_id
    client_secret = var.gsuite_client_secret
    apps_domain   = var.email_domain
  }
}

#resource "cloudflare_access_identity_provider" "github_oauth" {
#  account_id = var.cloudflare_account_id
#  name       = "GitHub OAuth LB"
#  type       = "github"
#  config {
#    client_id     = var.github_oauth_lb_client_id
#    client_secret = var.github_oauth_lb_client_secret
#  }
#}
