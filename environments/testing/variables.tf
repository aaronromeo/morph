variable "DOMAIN" {
  description = "Domain name"
  type        = string
}

variable "SUBDOMAIN" {
  description = "Subdomain name"
  type        = string
  default     = "postmanpat-test"  # Note different default for testing
}

variable "PVT_KEY" {
  description = "Path to the SSH private key"
  type        = string
}

variable "pvt_key_file" {
  description = "Name of the SSH private key"
  type        = string
  default     = "do_tf"
}

# Reference to module variables
variable "DO_TOKEN" {}
variable "IMAP_PASS" {}
variable "IMAP_URL" {}
variable "IMAP_USER" {}
variable "DIGITALOCEAN_BUCKET_ACCESS_KEY" {}
variable "DIGITALOCEAN_BUCKET_SECRET_KEY" {}
variable "DIGITALOCEAN_CONTAINER_REGISTRY_TOKEN" {}
variable "DIGITALOCEAN_USER" {}
variable "SSH_FINGERPRINTS" { type = list(string) }
variable "region" {
  default = "nyc3"
}
variable "UPTRACE_DSN" {}