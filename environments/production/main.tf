module "droplet" {
  source = "../../modules/droplet"

  environment = "production"
  droplet_size = "s-1vcpu-1gb"
  region = var.region
  SSH_FINGERPRINTS = var.SSH_FINGERPRINTS
  # ... other variables
}

# Production-specific resources
resource "digitalocean_domain" "app_domain" {
  name = var.DOMAIN
}

resource "digitalocean_record" "subdomain" {
  domain = digitalocean_domain.app_domain.name
  type   = "A"
  name   = var.SUBDOMAIN
  ttl    = 1800
  value  = module.droplet.droplet_ip
}