data "aws_ami" "ubuntu_us-east-1" {
  #description = "to get ami id in us-east-1"
  provider    = aws.us-east-1
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-*"]
  }

}

data "aws_ami" "ubuntu_us-west-1" {
  #description = "to get ami id in us-west-1"
  provider    = aws.us-west-1
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-*"]
  }
}

data "aws_vpc" "vpc_us-east-1" {
  provider = aws.us-east-1
  default  = true
}

data "aws_vpc" "vpc_us-west-1" {
  provider = aws.us-west-1
  default  = true
}

data "aws_security_group" "aws-sec-us-east-1" {
  provider = aws.us-east-1
  vpc_id   = data.aws_vpc.vpc_us-east-1.id
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_us-east-1.id]
  }
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_security_group" "aws-sec-us-west-1" {
  provider = aws.us-west-1
  vpc_id   = data.aws_vpc.vpc_us-west-1.id
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_us-west-1.id]
  }
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

