terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.15.0"
    }
    random     = {
      version = "~> 3.2.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
}
