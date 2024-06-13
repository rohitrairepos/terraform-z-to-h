
/*
locals {
  subnet = {for subnet in aws_subnet.dev-vpc-subnet : subnet.id => subnet.id}
  depends_on = [aws_subnet.dev-vpc-subnet]
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.dev-vpc.id]
  }
}


locals {
  subnet_ids = data.aws_subnets.selected.ids
}
*/

resource "aws_key_pair" "ssh_login" {
  key_name   = "tf-rrai"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web-app" {
  /*
    #for_each = {for subnet_id in data.aws_subnets.selected.ids : subnet_id => subnet_id}
    #for_each = {for subnet_id in local.subnet_ids : subnet_id => subnet_id}
    #for_each = {for subnet in aws_subnet.dev-vpc-subnet : subnet.id => subnet.id}
    #error which will come 
    The "for_each" map includes keys derived from resource attributes that 
    cannot be determined until apply, and so Terraform cannot determine the 
    full set of keys that will identify the instances of this
│   resource.

    */

  for_each      = aws_subnet.dev-vpc-subnet
  ami           = data.aws_ami.ami_id.id
  instance_type = var.intance_type
  #security_groups = [aws_security_group.sg_ssh.name] you can't use group name with subnet id
  subnet_id       = each.value.id
  security_groups = [aws_security_group.sg_ssh_http_icmp.id]
  key_name        = aws_key_pair.ssh_login.key_name
  /*
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }
    */
  tags = {
    Name = "${each.value.availability_zone}-${substr(each.value.id, -4, 4)}-${var.vpc_tag}"
  }
}



/*
output "subnet" {
  value = aws_subnet.dev-vpc-subnet
  
}
*/