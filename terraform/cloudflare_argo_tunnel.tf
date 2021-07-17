resource "random_id" "secret-1" {
  byte_length = 32
}

resource "cloudflare_argo_tunnel" "tunnel1" {
  name       = "cloudflaredtunnel1"
  account_id = var.cloudflare_account_id
  secret     = random_id.secret-1.b64_std
}
