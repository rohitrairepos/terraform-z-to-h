terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform.freetier08"
    key            = "terraform-folders/terraform-vpc.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
