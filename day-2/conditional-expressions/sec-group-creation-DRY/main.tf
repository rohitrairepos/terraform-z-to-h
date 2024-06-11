terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.51.1"
    }
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"

}


data "aws_vpc" "us-east-1-default" {
  provider = aws.us-east-1
  default  = true

}


data "aws_vpc" "us-west-1-default" {
  provider = aws.us-west-1
  default  = true
}

resource "aws_security_group" "web_sg-us-east-1" {
  name        = "web_sg-us-east-1"
  description = "sec group for us-east-1"
  provider    = aws.us-east-1
  vpc_id      = data.aws_vpc.us-east-1-default.id

  tags = {
    Name = "web_sg-us-east-1"
  }
}
resource "aws_security_group" "web_sg-us-west-1" {
  name        = "web_sg-us-west-1"
  description = "sec group for us-west-1"
  provider    = aws.us-west-1
  vpc_id      = data.aws_vpc.us-west-1-default.id

  tags = {
    Name = "web_sg-us-west-1"
  }


}
resource "aws_security_group_rule" "allow_http_ssh_icmp_us-east-1" {
  for_each          = local.security_groups_protocol
  provider          = aws.us-east-1
  type              = "ingress"
  protocol          = each.value
  from_port         = lookup({ ssh = 22, http = 80, icmp = -1 }, each.key, -1)
  to_port           = lookup({ ssh = 22, http = 80, icmp = -1 }, each.key, -1)
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg-us-east-1.id

}
resource "aws_security_group_rule" "allow_all-us-east-1" {
  provider          = aws.us-east-1
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg-us-east-1.id

}
resource "aws_security_group_rule" "allow_http_ssh_icmp_us-west-1" {
  for_each = {
    for protocol, type in local.security_groups_protocol : protocol => type
    if protocol != "http"
  }
  provider          = aws.us-west-1
  type              = "ingress"
  protocol          = each.value
  from_port         = lookup({ ssh = 22, icmp = -1 }, each.key, -1)
  to_port           = lookup({ ssh = 22, icmp = -1 }, each.key, -1)
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg-us-west-1.id

}
resource "aws_security_group_rule" "allow_all-us-west-1" {
  provider          = aws.us-west-1
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg-us-west-1.id

}


