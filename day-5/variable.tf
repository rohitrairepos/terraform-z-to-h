variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  description = "A list of maps defining subnets"
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  default = [
    {
      name = "subnet-1"
      cidr = "10.0.1.0/24"
      az   = "us-east-1a"
    },
    {
      name = "subnet-2"
      cidr = "10.0.2.0/24"
      az   = "us-east-1b"
    },
    {
      name = "subnet-3"
      cidr = "10.0.3.0/24"
      az   = "us-east-1c"
    }
  ]
}



variable "vpc_tag" {
  description = "tag for vpc"
  type        = string
  default     = "new_vpc"
}