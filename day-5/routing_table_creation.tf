

resource "aws_route_table" "custom_route_table" {
  vpc_id   = aws_vpc.dev-vpc.id
  for_each = aws_subnet.dev-vpc-subnet
  tags = {
    Name = "rt-${each.value.availability_zone}"
  }
}


resource "aws_route_table_association" "custom_route_table_association" {
  for_each       = aws_subnet.dev-vpc-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.custom_route_table[each.key].id
}


# Local value to filter the subnets
locals {
  subnets_in_az1 = { for key, subnet in aws_subnet.dev-vpc-subnet : key => subnet if substr(subnet.availability_zone, -1, 1) == "a" }
}

## add internet gateway route to az1 only 
resource "aws_route" "add_route_in_az1" {
  for_each               = local.subnets_in_az1
  #for_each = {for key, subnet in aws_subnet.dev-vpc-subnet : key => subnet if substr(subnet.availability_zone, -1, 1) == "a"}
  # if define above #for_each then no need to define locals 
  route_table_id         = aws_route_table.custom_route_table[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_dev_igw.id
  lifecycle {
    ignore_changes = [
      gateway_id
    ]
  }


}



locals {
  subnets_in_az2 = { for key, subnet in aws_subnet.dev-vpc-subnet : key => subnet if substr(subnet.availability_zone, -1, 1) == "b" }
}


/*
nat_gw_id      = { for key, nat_gw in aws_nat_gateway.nat_gw : key => nat_gw.id } 
output is :
aws_internet_gateway = {
  "dev-vpc-us-east-1a" = "nat-0513acf163459d9ff"
}


nat_gw_id_list = values(local.nat_gw_id) 
output is :

aws_internet_gateway = [
      - "nat-0513acf163459d9ff",
    ]
*/



locals {
  nat_gw_id      = { for key, nat_gw in aws_nat_gateway.nat_gw : key => nat_gw.id }
  nat_gw_id_list = values(local.nat_gw_id)
}

## add nat-gw route to az2 only 
resource "aws_route" "add_route_in_az2" {
  for_each               = local.subnets_in_az2
  route_table_id         = aws_route_table.custom_route_table[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = local.nat_gw_id_list[0]


}


