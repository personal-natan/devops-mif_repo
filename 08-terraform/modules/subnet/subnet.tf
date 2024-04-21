resource "aws_subnet" "PublicSubnet_1" {
  vpc_id = var.vpc_id
  cidr_block = var.pub_subnet_cidr_block
  availability_zone = var.zone
  
  map_public_ip_on_launch = true
  
  tags = {
    Name = var.subnet_name
  }
}

output "subnet_id" {
  value = aws_subnet.PublicSubnet_1.id
}
