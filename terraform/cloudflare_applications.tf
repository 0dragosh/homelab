locals {
  apps = [
    "bazarr",
    "grafana",
    "nzbget",
    "plex-requests",
    "prowlarr",
    "radarr",
    "readarr",
    "sonarr",
    "tautulli",
  ]
}

resource "cloudflare_access_application" "app" {
  for_each = {for app in local.apps:  app => app}

  zone_id                   = var.zone_id
  name                      = each.value
  domain                    = "${each.value}.${var.domain}"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = true
}

resource "cloudflare_access_policy" "policy" {
  for_each = {for app in cloudflare_access_application.app:  app => app}

  zone_id        = var.zone_id
  application_id = each.value.id

  name           = "allow cloudpush"
  precedence     = "1"
  decision       = "allow"

  include {
    email_domain = [var.email_domain]
  }
}
