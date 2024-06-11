resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    Name = "eip-${var.vpc_tag}"
  }

}


resource "aws_nat_gateway" "nat_gw" {
  for_each          = local.subnets_in_az1
  allocation_id     = aws_eip.eip.id
  subnet_id         = each.value.id
  connectivity_type = "public" ## no need to mention , by default pulic

  tags = {
    Name = "NAT-gw-${var.vpc_tag}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.vpc_dev_igw]
}

