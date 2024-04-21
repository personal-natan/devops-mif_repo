locals {
  name_only = [
    {
      nameKey   = "Name"
      nameValue = var.tagName
    },
  ]
}

resource "aws_eip" "nat_test" {
  # depends_on = [ aws_internet_gateway.igw-test ]
  tags = {
    for tag in local.name_only:
    tag.nameKey => "${tag.nameValue}-nat"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_test.id
  subnet_id = var.subnet_id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}