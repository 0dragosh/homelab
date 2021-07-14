resource "cloudflare_argo_tunnel" "tunnel" {
  account_id = var.cloudflare_account_id
  name       = "tunnel"
  secret     = var.cloudflare_argo_tunnel_secret
}
