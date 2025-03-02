# Move common infrastructure code here
resource "digitalocean_droplet" "postmanpat" {
  image    = "ubuntu-22-04-x64"
  name     = "docker-ubuntu-${var.environment}"
  region   = var.region
  size     = var.droplet_size
  ssh_keys = var.SSH_FINGERPRINTS

  tags = ["postmanpat", var.environment]

  # ... rest of your droplet configuration
}