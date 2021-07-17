output "cloudflare_access_service_token" {
  value     = cloudflare_access_service_token.token
  sensitive = true
}

output "cloudflare_argo_tunnel_1" {
  value     = cloudflare_argo_tunnel.tunnel1
  sensitive = true
}
