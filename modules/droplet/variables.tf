variable "DO_TOKEN" {
  description = "DigitalOcean API token"
  type        = string
}

variable "IMAP_PASS" {
  description = "IMAP password"
  type        = string
}

variable "IMAP_URL" {
  description = "IMAP URL"
  type        = string
}

variable "IMAP_USER" {
  description = "IMAP user"
  type        = string
}

variable "DIGITALOCEAN_BUCKET_ACCESS_KEY" {
  description = "Digitaocean bucket access key"
  type        = string
}

variable "DIGITALOCEAN_BUCKET_SECRET_KEY" {
  description = "Digitaocean bucket secret key"
  type        = string
}

variable "DIGITALOCEAN_CONTAINER_REGISTRY_TOKEN" {
  description = "Digitaocean container registry token"
  type        = string
}

variable "DIGITALOCEAN_USER" {
  description = "Digitaocean user"
  type        = string
}

variable "SSH_FINGERPRINTS" {
  description = "SSH key fingerprints"
  type        = list(string)
}

variable "region" {
  description = "Digitalocean region"
  type        = string
  default     = "nyc3"
}

variable "UPTRACE_DSN" {
  description = "Uptrace DSN"
  type        = string
}

variable "environment" {
  description = "Environment name (production or testing)"
  type        = string
}

variable "droplet_size" {
  description = "Size of the droplet"
  type        = string
}
