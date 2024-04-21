locals {
  standard_tags = [
    {
      nameKey   = "Name"
      nameValue = var.tagName
    },
    {
      nameKey   = "project"
      nameValue = var.tagProject
    },
    {
      nameKey   = "environment"
      nameValue = var.tagEnvironment
    },
  ]
}

locals {
  name_only = [
    {
      nameKey   = "Name"
      nameValue = var.tagName
    },
  ]
}

resource "aws_vpc" "test-dev" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  assign_generated_ipv6_cidr_block = false
  instance_tenancy = "default"

  tags = {
    for tag in local.standard_tags:
    tag.nameKey => tag.nameValue
  }
}

# output variable
output "vpc_id" {
  value = aws_vpc.test-dev.id
}

output "standard_tags" {
  value = local.standard_tags
}