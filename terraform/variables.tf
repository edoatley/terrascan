variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_subnets" {
  description = "The CIDR blocks for the VPC subnets"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    subnet1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "eu-west-1a"
    },
    subnet2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "eu-west-1b"
    },
    subnet3 = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "eu-west-1c"
    }
  }
}

variable "override_ip_address" {
  description = "The IP address to use for the security group"
  type        = string
  default     = null
}

variable "ec2_private_ip" {
  description = "The private IP address to use for the EC2 instance"
  type        = string
  default     = "10.0.1.8"
}