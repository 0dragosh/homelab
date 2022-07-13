resource "google_kms_key_ring" "keyring" {
  name     = "homelab"
  location = "global"
}

resource "google_kms_crypto_key" "vault" {
  name            = "vault"
  key_ring        = google_kms_key_ring.keyring.id

  lifecycle {
    prevent_destroy = true
  }
}
