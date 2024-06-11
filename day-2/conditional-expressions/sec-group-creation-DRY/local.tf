locals {
  security_groups_protocol = {

    ssh  = "tcp",
    http = "tcp",
    icmp = "icmp"
  }
} 