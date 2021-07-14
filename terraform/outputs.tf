output "cloudflare_access_service_token" {
  value     = cloudflare_access_service_token.token
  sensitive = true
}

output "cloudflare_tunnel" {
  value     = cloudflare_argo_tunnel.tunnel
  sensitive = true
}
