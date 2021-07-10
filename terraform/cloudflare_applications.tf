locals {
  apps = [
    "sonarr",
    "radarr",
  ]
}

resource "cloudflare_access_application" "app" {
  for_each = local.apps

  zone_id                   = var.zone_id
  name                      = each.value
  domain                    = ".${var.domain}"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = true
}
