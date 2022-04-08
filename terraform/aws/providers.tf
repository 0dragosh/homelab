terraform {
  required_providers {
    cloudflare = {
      source  = "hashicorp/aws"
      version = "~> 4.9.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
