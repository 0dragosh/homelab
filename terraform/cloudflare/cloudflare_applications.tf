locals {
  apps_casa = [
    {
      subdomain = "bazarr"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "calibre"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "calibre-web"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "filebrowser"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "change-detection"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "grafana"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "hass"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "s3"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "nzbget"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "requests"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "prowlarr"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "qbittorrent"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "radarr"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "readarr"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "readarr-audiobooks"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "sonarr"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "storage"
      type      = "ssh"
      gsuite    = true
    },
    {
      subdomain = "nuc1"
      type      = "ssh"
      gsuite    = true
    },
    {
      subdomain = "nuc2"
      type      = "ssh"
      gsuite    = true
    },
    {
      subdomain = "nuc3"
      type      = "ssh"
      gsuite    = true
    },
    {
      subdomain = "tautulli"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "unifi"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "vault"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "edgerouter"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "falcosidekick-ui"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "falcosidekick"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "tv"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "rook"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "alert-manager"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "prometheus"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "recipes"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "omada"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "jellyfin"
      type      = "self_hosted"
      gsuite    = true
    },
#    {
#      subdomain = "plex"
#      type      = "self_hosted"
#      gsuite    = true
#    },
    {
      subdomain = "truenas"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "mylar"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "pyload"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "tdarr"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "minio"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "qnap"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "zigbee2mqtt"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "nodered"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "mosquitto"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "frigate"
      type      = "self_hosted"
      gsuite    = true
    },
  ]
  apps_secondary = [
    {
      subdomain = "calibre-web"
      type      = "self_hosted"
      gsuite    = true
    },
    {
      subdomain = "requests"
      type      = "self_hosted"
      gsuite    = true
    },
  ]
}

resource "cloudflare_access_service_token" "token" {
  for_each   = {for app in local.apps_casa : app.subdomain => app}
  account_id = var.cloudflare_account_id
  name       = each.value.subdomain
}

resource "cloudflare_access_application" "app_casa" {
  for_each = {for app in local.apps_casa : app.subdomain => app}

  zone_id                   = var.zone_id_casa
  name                      = each.value.subdomain
  domain                    = "${each.value.subdomain}.${var.domain_casa}"
  type                      = each.value.type
  session_duration          = "336h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "app_secondary" {
  for_each = {for app in local.apps_secondary : app.subdomain => app}

  zone_id                   = var.zone_id
  name                      = each.value.subdomain
  domain                    = "${each.value.subdomain}.${var.domain}"
  type                      = each.value.type
  session_duration          = "336h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_application" "kobo" {
  zone_id                   = var.zone_id_casa
  name                      = "kobo"
  domain                    = "calibre-web.${var.domain_casa}/kobo"
  type                      = "self_hosted"
  session_duration          = "336h"
  auto_redirect_to_identity = false
}
