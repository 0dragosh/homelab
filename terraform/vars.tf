variable "cloudflare_email" {
  type      = string
  sensitive = true
}

variable "cloudflare_account_id" {
  type      = string
  sensitive = true
}

variable "cloudflare_api_key" {
  type      = string
  sensitive = true
}

variable "cloudflare_argo_tunnel_secret" {
  type      = string
  sensitive = true
}

variable "domain" {
  type      = string
  sensitive = true
}

variable "zone_id" {
  type      = string
  sensitive = true
}

variable "email_domain" {
  type      = string
  sensitive = true
}

variable "gsuite_client_id" {
  type      = string
  sensitive = true
}

variable "gsuite_client_secret" {
  type      = string
  sensitive = true
}

#variable "github_oauth_lb_client_id" {
#  type      = string
#  sensitive = true
#}
#
#variable "github_oauth_lb_client_secret" {
#  type      = string
#  sensitive = true
#}
