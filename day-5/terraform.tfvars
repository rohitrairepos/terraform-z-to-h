vpc_cidr_block = "192.168.24.0/24"
vpc_tag        = "dev-vpc"

subnets = [
  {
    name = "dev-vpc-us-east-2a"
    cidr = "192.168.24.0/27"
    az   = "us-east-2a"
  },
  {
    name = "dev-vpc-us-east-2b"
    cidr = "192.168.24.32/27"
    az   = "us-east-2b"
  },
  {
    name = "dev-vpc-us-east-2c"
    cidr = "192.168.24.64/27"
    az   = "us-east-2c"
  }
]

intance_type = "t2.micro"