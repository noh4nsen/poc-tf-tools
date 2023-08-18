terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
      }
      random = {
        source = "hashicorp/random"
      }
    }

    backend "remote" {
        organization = "lab-acg"
        workspaces {
          name = "test"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "random_name" "sg" {}


resource "aws_instance" "web" {
    ami = "ami-09e67e426f25cd0d7"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web-sg.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
}

resource "aws_security_group" "web-sg" {
    name = "{random_name.sg.id}-sg"
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "web-address" {
    value = "${aws_instance.web.public_dns}:8080"
}