data "aws_ami" "ubuntu_image_id" {

  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240529.0-*"]
  }

}



data "aws_security_group" "name" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

}


/*
output "ubuntu" {
  value = data.aws_ami.ubuntu_image_id.id
  
}

output "sec-group-name" {
  value = data.aws_security_group.name.id
  
}
*/