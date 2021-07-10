locals {
  apps = [
    "sonarr",
    "radarr",
  ]
}

resource "cloudflare_access_application" "app" {
  for_each = {for i, app in local.apps:  i => app}

  zone_id                   = var.zone_id
  name                      = each.value
  domain                    = "${each.value}.${var.domain}"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = true
}
