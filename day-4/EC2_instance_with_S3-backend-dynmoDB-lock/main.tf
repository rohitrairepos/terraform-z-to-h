


resource "aws_instance" "web-app-1" {
    ami = data.aws_ami.ubuntu.id
    key_name = "rrai-key"
    security_groups = [data.aws_security_group.default_sec_group.name]
    instance_type = "t2.micro"
    tags = {
      Name = "web-app-1"
    }
  
}