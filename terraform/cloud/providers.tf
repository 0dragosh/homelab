terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.19.0"
    }
    google = {
      source = "hashicorp/google"
      version = "~> 4.28.0"
    }
  }
}

provider "cloudflare" {}

provider "google" {
  project     = "homelab-terraform-x478b"
  region      = "europe-west3"
  zone        = "europe-west3-b"
}
