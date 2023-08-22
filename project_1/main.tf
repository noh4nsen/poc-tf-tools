terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = "false"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "test_nginx"
  ports {
    internal = 80
    external = 8080
  }
}

resource "docker_container" "nginx2" {
  image = docker_image.nginx.image_id
  name  = "test_nginx_2"
  ports {
    internal = 80
    external = 8081
  }
}