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
      availability_zone = "us-east-1a"
    },
    subnet2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
    },
    subnet3 = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1c"
    }
  }
}

variable "override_ip_address" {
  description = "The IP address to use for the security group"
  type        = string
  default     = null
}