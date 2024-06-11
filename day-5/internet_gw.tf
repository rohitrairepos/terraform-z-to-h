resource "aws_internet_gateway" "vpc_dev_igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "igw-${var.vpc_tag}"
  }

}