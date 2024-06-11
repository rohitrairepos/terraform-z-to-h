resource "aws_instance" "web-app-us-east-1" {
  count           = 2
  provider        = aws.us-east-1
  ami             = data.aws_ami.ubuntu_us-east-1.id
  instance_type   = var.ami-type-us-east-1
  security_groups = [data.aws_security_group.aws-sec-us-east-1.name]
  key_name        = var.key_name
  tags = {
    "Name" = "web-app-us-east-${count.index}"
  }
}

resource "aws_instance" "web-app-us-west-1" {
  count           = 2
  provider        = aws.us-west-1
  ami             = data.aws_ami.ubuntu_us-west-1.id
  instance_type   = var.ami-type-us-west-1
  security_groups = [data.aws_security_group.aws-sec-us-west-1.name]
  key_name        = var.key_name
  tags = {
    "Name" = "web-app-us-west-${count.index}"
  }
}
