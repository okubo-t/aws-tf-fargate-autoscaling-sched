## aws account reference
data "aws_caller_identity" "current" {}

## region
variable "aws_region" {
  default = "ap-northeast-1"
}

## prefix
variable "prefix" {
  default = "prefix"
}

## environment
variable "env" {
  default = "demo"
}

## IP for remote access to abl
variable "my_remote_ip" {
  default = "0.0.0.0/0"
}
