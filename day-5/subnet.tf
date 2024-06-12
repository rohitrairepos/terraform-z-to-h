resource "aws_subnet" "dev-vpc-subnet" {
  for_each          = { for subnet in var.subnets : subnet.name => subnet }
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = substr(each.value.az, -1, 1) == "a" ? true : false

  tags = {
    Name = each.value.name
  }
  depends_on = [aws_vpc.dev-vpc]
}

/*
output "aws_subnet" {
    ##value = {for subnet  in aws_subnet.dev-vpc-subnet : subnet.availability_zone_id => subnet.cidr_block }
    value = aws_subnet.dev-vpc-subnet
}
*/