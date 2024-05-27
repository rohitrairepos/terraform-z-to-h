locals {
  security_groups_vars = {
    type = "ingress"
    ssh_port = 22
    http_port = 80
    no_port = -1
    protocol_tcp = "tcp"
    protocol_icmp = "icmp"
    cidr_blocks = ["0.0.0.0/0"]


  }
}

