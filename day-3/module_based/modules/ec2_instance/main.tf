terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}

/*
provider "aws" {
  region = "us-east-1"
  
}
*/

resource "aws_instance" "web" {

  ami             = data.aws_ami.ubuntu_image_id.id
  instance_type   = var.instance_type
  security_groups = [data.aws_security_group.name.name]

}