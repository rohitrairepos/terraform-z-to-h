terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {

  region = "us-east-1"

}

resource "aws_instance" "web" {
  ami                    = "ami-021ae75bdd155a4d5"
  instance_type          = "t3.micro"
  key_name               = "rrai-key"
  vpc_security_group_ids = ["sg-02b9e021054634ee7"]

}