# Move common infrastructure code here
resource "digitalocean_droplet" "postmanpat" {
  image    = "ubuntu-22-04-x64"
  name     = "docker-ubuntu-${var.environment}"
  region   = var.region
  size     = var.droplet_size
  ssh_keys = var.SSH_FINGERPRINTS

  tags = ["postmanpat", var.environment]

  user_data = <<-EOF
    #!/bin/bash

    # Enable strict mode
    set -euxo pipefail

    echo '
      export IMAP_URL="${var.IMAP_URL}"
      export IMAP_USER="${var.IMAP_USER}"
      export IMAP_PASS="${var.IMAP_PASS}"

      export DIGITALOCEAN_BUCKET_ACCESS_KEY="${var.DIGITALOCEAN_BUCKET_ACCESS_KEY}"
      export DIGITALOCEAN_BUCKET_SECRET_KEY="${var.DIGITALOCEAN_BUCKET_SECRET_KEY}"
      export DIGITALOCEAN_CONTAINER_REGISTRY_TOKEN="${var.DIGITALOCEAN_CONTAINER_REGISTRY_TOKEN}"
      export DIGITALOCEAN_USER="${var.DIGITALOCEAN_USER}"

      export UPTRACE_DSN="${var.UPTRACE_DSN}"
    ' > /etc/profile.d/postmanpat.sh

    chmod +x /etc/profile.d/postmanpat.sh

    snap install doctl
  EOF
}

resource "null_resource" "source_files" {
  triggers = {
    droplet_id            = digitalocean_droplet.postmanpat.id
    main_script_sha256    = filemd5("${path.module}/../../provision/main.sh")
    update_script_sha256  = filemd5("${path.module}/../../workingfiles/update-script.sh")
    hooks_json_sha256     = filemd5("${path.module}/../../provision/hooks.json")
    docker_compose_sha256 = filemd5("${path.module}/../../workingfiles/docker-compose.yml")
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      agent = true
      host  = digitalocean_droplet.postmanpat.ipv4_address
    }
    source      = "${path.module}/../../provision/main.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      agent = true
      host  = digitalocean_droplet.postmanpat.ipv4_address
    }
    source      = "${path.module}/../../workingfiles/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      agent = true
      host  = digitalocean_droplet.postmanpat.ipv4_address
    }
    source      = "${path.module}/../../workingfiles/update-script.sh"
    destination = "/usr/local/bin/update-script.sh"
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "root"
      agent = true
      host  = digitalocean_droplet.postmanpat.ipv4_address
    }
    source      = "${path.module}/../../provision/hooks.json"
    destination = "/etc/webhook/hooks.json"
  }
}

resource "null_resource" "provision" {
  triggers = {
    droplet_id            = digitalocean_droplet.postmanpat.id
    main_script_sha256    = filemd5("${path.module}/../../provision/main.sh")
    update_script_sha256  = filemd5("${path.module}/../../workingfiles/update-script.sh")
    hooks_json_sha256     = filemd5("${path.module}/../../provision/hooks.json")
    docker_compose_sha256 = filemd5("${path.module}/../../workingfiles/docker-compose.yml")
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      agent = true
      host  = digitalocean_droplet.postmanpat.ipv4_address
    }
    inline = [
      "chmod +x /tmp/provision.sh",
      "/tmp/provision.sh",
      "/usr/local/bin/update-script.sh"
    ]
  }

  depends_on = [null_resource.source_files]
}

output "droplet_ip" {
  value = digitalocean_droplet.postmanpat.ipv4_address
}
