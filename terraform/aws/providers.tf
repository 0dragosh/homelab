terraform {
  required_providers {
    cloudflare = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
