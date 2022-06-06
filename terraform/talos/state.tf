terraform {
  backend "remote" {
    organization = "cloudpush"
    workspaces {
      name = "homelab-talos"
    }
  }
}
