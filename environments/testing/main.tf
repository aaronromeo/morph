module "droplet" {
  source = "../../modules/droplet"

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