variable "vpc" {
  type = map(string)
  default = {
    name = "test-vpc"
    cidr = "10.0.0.0/16"
  }
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "igw_name" {
  type    = string
  default = "test-igw"
}

variable "public_subnet_a" {
  type = map(string)
  default = {
    name = "test-public-a"
    cidr = "10.0.1.0/24"
  }
}

variable "public_subnet_c" {
  type = map(string)
  default = {
    name = "test-public-c"
    cidr = "10.0.2.0/24"
  }
}

variable "private_subnet_a" {
  type = map(string)
  default = {
    name = "test-private-a"
    cidr = "10.0.10.0/24"
  }
}

variable "private_subnet_c" {
  type = map(string)
  default = {
    name = "test-private-c"
    cidr = "10.0.20.0/24"
  }
}
