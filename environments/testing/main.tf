module "droplet" {
  source = "../../modules/droplet"

  DO_TOKEN = var.DO_TOKEN
  IMAP_PASS = var.IMAP_PASS
  IMAP_URL = var.IMAP_URL
  IMAP_USER = var.IMAP_USER
  DIGITALOCEAN_BUCKET_ACCESS_KEY = var.DIGITALOCEAN_BUCKET_ACCESS_KEY
  DIGITALOCEAN_BUCKET_SECRET_KEY = var.DIGITALOCEAN_BUCKET_SECRET_KEY
  DIGITALOCEAN_CONTAINER_REGISTRY_TOKEN = var.DIGITALOCEAN_CONTAINER_REGISTRY_TOKEN
  DIGITALOCEAN_USER = var.DIGITALOCEAN_USER
  UPTRACE_DSN = var.UPTRACE_DSN
  
  environment = "testing"
  droplet_size = "s-1vcpu-1gb"  # Could use smaller size for testing
  region = var.region
  SSH_FINGERPRINTS = var.SSH_FINGERPRINTS
  # ... other variables
}

# Testing-specific resources
resource "digitalocean_domain" "app_domain" {
  name = var.DOMAIN
}

resource "digitalocean_record" "subdomain" {
  domain = digitalocean_domain.app_domain.name
  type   = "A"
  name   = var.SUBDOMAIN
  ttl    = 300  # Lower TTL for testing
  value  = module.droplet.droplet_ip
}
