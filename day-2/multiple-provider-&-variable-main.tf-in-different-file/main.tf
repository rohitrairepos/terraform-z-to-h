
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.51.0"
    }
  }
}

provider "aws" {
  alias  = "east"
  region = "us-east-1"

}

provider "aws" {
  alias  = "west"
  region = "us-west-1"
}

resource "aws_instance" "web-app-east-1" {
  ami           = var.ami-name-us-east-1
  instance_type = var.instance-flavor
  key_name      = var.key-name
  provider      = aws.east
  tags = {
    Name = "web-app-east-1"
  }

}

resource "aws_instance" "web-app-west-1" {
  ami           = var.ami-name-us-west-1
  instance_type = var.instance-flavor
  key_name      = var.key-name
  provider      = aws.west
  tags = {
    Name = "web-app-west-1"
  }
}

output "web-app-east-1-public-ip" {
  description = "public ip of web-app-east-1 "
  value       = aws_instance.web-app-east-1.public_ip

}



output "web-app-webst-1-public-ip" {
  description = "public ip of web-app-east-1 "
  value       = aws_instance.web-app-west-1.public_ip

}