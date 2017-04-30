variable "vpc_name" {
  default = "training"
}

variable "vpc_cidr" {
  default = "10.100.0.0/16"
}

variable "key_name" {
  default = "amaury_aws"
}

variable "availability_zone" {
  default = "eu-west-1a"
}

variable "public_subnet_cidr" {
  default = "10.100.1.0/24"
}

variable "ami_id" {
  default = "ami-e079f893"
}

variable "classroom_size" {}