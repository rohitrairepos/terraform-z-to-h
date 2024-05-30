/*
output "ami_id_output_us-east-1" {
    value = data.aws_ami.ubuntu_us-east-1.id  
}

output "ami_id_output_us-west-1" {
    value = data.aws_ami.ubuntu_us-west-1.id  
}



output "sec-group_us-east-1" {
    #description = "to get security group id in us-east-1"
    value = data.aws_security_group.aws-sec-us-east-1.id 
}


output "sec-group_us-west-1" {
    #description = "to get security group id in us-east-1"
    value = data.aws_security_group.aws-sec-us-west-1.id
}
*/

output "instance_public_ip-us-east-1" {
  description = "Names and Public IP addresses of the web app instances"
  value = [
    for instance in aws_instance.web-app-us-east-1 : {
      name      = instance.tags["Name"]
      public_ip = instance.public_ip
    }
  ]
}

output "instance_public_ip-us-west-1" {
  description = "Names and Public IP addresses of the web app instances"
  value = [
    for instance in aws_instance.web-app-us-west-1 : {
      name      = instance.tags["Name"]
      public_ip = instance.public_ip
    }
  ]
}