provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"

}

provider "aws" {
  region = "us-west-1"
  alias  = "us-west-1"

}

module "aws_ec2-us-east-1" {
  source = "./modules/ec2_instance"
  providers = {
    aws = aws.us-east-1
  }
  instance_type = "t2.nano"
  login_key     = "rrai-key"

}

module "aws_ec2-us-west-1" {
  source = "./modules/ec2_instance"
  providers = {
    aws = aws.us-west-1

  }
  instance_type = "t2.nano"
  login_key     = "rrai-key"

}