locals {
  apps = [
    "bazarr",
    "dizque",
    "grafana",
    "hass",
    "longhorn",
    "nzbget",
    "plex-requests",
    "prowlarr",
    "qbittorrent",
    "radarr",
    "readarr",
    "resilio",
    "sonarr",
    "tautulli",
  ]

  apps_token = [
    "nzbget",
    "radarr",
    "sonarr",
  ]
}

resource "cloudflare_access_application" "app" {
  for_each = {for app in local.apps:  app => app}

  zone_id                   = var.zone_id
  name                      = each.value
  domain                    = "${each.value}.${var.domain}"
  type                      = "self_hosted"
  session_duration          = "240h"
  auto_redirect_to_identity = true
}

resource "cloudflare_access_policy" "policy" {
  for_each = cloudflare_access_application.app

  zone_id        = var.zone_id
  application_id = each.value.id

  name           = "allow ${var.email_domain}"
  precedence     = "10"
  decision       = "allow"

  include {
    service_token = contains(local.apps_token,each.value.name) ? [cloudflare_access_service_token.token.id] : []
    email_domain  = [var.email_domain]
  }
}

resource "cloudflare_access_policy" "requests" {
  zone_id        = var.zone_id
  application_id = cloudflare_access_application.app["plex-requests"].id

  name           = "allow github & gsuite for requests"
  precedence     = "20"
  decision       = "allow"

  include {
#    login_method = [cloudflare_access_identity_provider.github_oauth.id, cloudflare_access_identity_provider.gsuite.id]
    login_method = [cloudflare_access_identity_provider.gsuite.id]
  }
}

resource "cloudflare_access_service_token" "token" {
  zone_id        = var.zone_id
  account_id     = var.cloudflare_account_id
  name           = "service token"
}
