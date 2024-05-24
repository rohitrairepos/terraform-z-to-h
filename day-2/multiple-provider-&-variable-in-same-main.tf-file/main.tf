variable "ami-name-us-east-1" {
  description = "ami id for instances"
  type        = string
  default     = "ami-0bb84b8ffd87024d8"

}

variable "ami-name-us-west-1" {
  description = "ami id for instances"
  type        = string
  default     = "ami-0cbe318e714fc9a82"

}


variable "instance-flavor" {
  description = "instance type"
  type        = string
  default     = "t2.micro"

}

variable "key-name" {
  description = "key pair name to login into EC2 instances"
  type        = string
  default     = "rrai-key"

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