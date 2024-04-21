variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "cidr value, /16"
}

variable "enable_dns_hostnames" {
  type = bool
  default = false
}

variable "enable_dns_support" {
  type = bool
  default = false
}

variable "tagName" {
  type = string
}

variable "tagProject" {
  type = string
}

variable "tagEnvironment" {
  type = string
}