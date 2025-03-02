terraform {
  cloud {
    organization = "your-org-name"
    workspaces {
      name = "postmanpat-production"
    }
  }

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.40.0"
    }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
}