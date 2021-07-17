resource "cloudflare_argo" "tunnel-1" {
  zone_id = var.zone_id
}

resource "cloudflare_argo" "tunnel-2" {
  zone_id = var.zone_id
}
