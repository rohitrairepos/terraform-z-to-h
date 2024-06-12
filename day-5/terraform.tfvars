vpc_cidr_block = "192.168.24.0/24"
vpc_tag        = "dev-vpc"

subnets = [
  {
    name = "dev-vpc-us-east-1a"
    cidr = "192.168.24.0/27"
    az   = "us-east-1a"
  },
  {
    name = "dev-vpc-us-east-1b"
    cidr = "192.168.24.32/27"
    az   = "us-east-1b"
  },
  {
    name = "dev-vpc-us-east-1c"
    cidr = "192.168.24.64/27"
    az   = "us-east-1c"
  }
]