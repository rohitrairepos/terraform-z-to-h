data "aws_ami" "ami_id" {
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.20240611.0-kernel-6.1-x86_64"]

  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"]

}