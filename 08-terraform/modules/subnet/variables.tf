variable "pub_subnet_cidr_block" {
    type = string
    default = "10.0.1.0/24"
    description = "cidr value, /16"
}

variable "vpc_id" {
  type = string
  description = "got from output of vpc module"
}

variable "zone" {
  type = string
  description = "must be set in main.yaml"
}

variable "subnet_name" {
  type = string
}