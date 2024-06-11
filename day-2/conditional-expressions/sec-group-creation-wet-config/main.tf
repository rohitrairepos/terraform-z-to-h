terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.51.0"
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

data "aws_vpc" "default-us-east-1" {
  provider = aws.us-east-1
  default  = true

}

data "aws_vpc" "default-us-west-1" {
  provider = aws.us-west-1
  default  = true

}


resource "aws_security_group" "web_sg-us-east-1" {
  name        = "web_sg-us-east-1"
  description = "Security group for us-east-1"
  vpc_id      = data.aws_vpc.default-us-east-1.id
  provider    = aws.us-east-1
  tags = {
    Name = "web_sg-us-east-1"
  }

}


resource "aws_security_group" "web_sg-us-west-1" {
  name        = "web_sg-us-west-1"
  description = "Security group for us-west-1"
  vpc_id      = data.aws_vpc.default-us-west-1.id
  provider    = aws.us-west-1
  tags = {
    Name = "web_sg-us-west-1"
  }


}


resource "aws_security_group_rule" "allow_ssh_us-east-1" {
  provider          = aws.us-east-1
  type              = local.security_groups_vars.type
  from_port         = local.security_groups_vars.ssh_port
  to_port           = local.security_groups_vars.ssh_port
  protocol          = local.security_groups_vars.protocol_tcp
  cidr_blocks       = local.security_groups_vars.cidr_blocks
  security_group_id = aws_security_group.web_sg-us-east-1.id

}

resource "aws_security_group_rule" "allow_http_us-east-1" {
  provider          = aws.us-east-1
  type              = local.security_groups_vars.type
  from_port         = local.security_groups_vars.http_port
  to_port           = local.security_groups_vars.http_port
  protocol          = local.security_groups_vars.protocol_tcp
  cidr_blocks       = local.security_groups_vars.cidr_blocks
  security_group_id = aws_security_group.web_sg-us-east-1.id

}

resource "aws_security_group_rule" "allow_icmp_us-east-1" {
  provider          = aws.us-east-1
  type              = local.security_groups_vars.type
  from_port         = local.security_groups_vars.no_port
  to_port           = local.security_groups_vars.no_port
  protocol          = local.security_groups_vars.protocol_icmp
  cidr_blocks       = local.security_groups_vars.cidr_blocks
  security_group_id = aws_security_group.web_sg-us-east-1.id

}


resource "aws_security_group_rule" "allow_ssh_us-west-1" {
  provider          = aws.us-west-1
  type              = local.security_groups_vars.type
  from_port         = local.security_groups_vars.ssh_port
  to_port           = local.security_groups_vars.ssh_port
  protocol          = local.security_groups_vars.protocol_tcp
  cidr_blocks       = local.security_groups_vars.cidr_blocks
  security_group_id = aws_security_group.web_sg-us-west-1.id

}


resource "aws_security_group_rule" "allow_icmp_us-west-1" {
  provider          = aws.us-west-1
  type              = local.security_groups_vars.type
  from_port         = local.security_groups_vars.no_port
  to_port           = local.security_groups_vars.no_port
  protocol          = local.security_groups_vars.protocol_icmp
  cidr_blocks       = local.security_groups_vars.cidr_blocks
  security_group_id = aws_security_group.web_sg-us-west-1.id

}

/*

Terraform's provider configuration requires a static, not dynamic, reference. 
Instead of directly using dynamic references, you can define each resource separately and then loop over them.

locals {
  security_groups = {
    us-east-1 = {
        provider_alias = "us_east_1"
        id = aws_security_group.web_sg-us-east-1.id
    }

    us-west-1 = {
        provider_alias = "us_west_1"
        id = aws_security_group.web_sg-us-west-1.id

    }


  }
}



resource "aws_security_group_rule" "allow-ssh" {

    for_each = local.security_groups
    provider = aws."${each.value.provider_alias}"
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = each.value.id
    
  
}
*/

