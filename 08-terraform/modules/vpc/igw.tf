## INTERNET GATEWAY
resource "aws_internet_gateway" "igw-test" {
  vpc_id = aws_vpc.test-dev.id
  tags = {
    for tag in local.name_only:
    tag.nameKey => "${tag.nameValue}-igw"
  }
}

output "igw_id" {
  value = aws_internet_gateway.igw-test.id
}