terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "servidor_lab" {
  name  = "servidor-lab"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = var.puerto_externo
  }
}
