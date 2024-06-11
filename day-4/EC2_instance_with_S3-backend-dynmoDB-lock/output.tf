
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-*-20240423"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }


  owners = ["099720109477"]
}

data "aws_security_group" "default_sec_group" {
  filter {
    name   = "group-name"
    values = ["*default*"]
  }


}