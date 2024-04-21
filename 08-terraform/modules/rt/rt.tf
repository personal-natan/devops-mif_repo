locals {
  name_only = [
    {
      nameKey   = "Name"
      nameValue = var.tagName
    },
  ]
}

## ROUTE TABLE
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    for tag in local.name_only:
    tag.nameKey => "${tag.nameValue}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    for tag in local.name_only:
    tag.nameKey => "${tag.nameValue}-private"
  }
  # depends_on = [ aws_nat_gateway.nat_gw_01 ]
}

output "rt_public_id" {
  value = aws_route_table.public.id
}

output "rt_private_id" {
  value = aws_route_table.private.id
}