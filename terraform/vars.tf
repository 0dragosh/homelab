variable "cloudflare_email" {
  type      = string
  sensitive = true
}

variable "cloudflare_api_key" {
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
