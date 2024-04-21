resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for EC2 instance"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_test" {
  ami                    = var.ami
  instance_type          = var.ec2_type
  subnet_id              = var.subnet_id
  associate_public_ip_address = false
  security_groups        = [aws_security_group.instance_sg.name]
  
  root_block_device {
    volume_size = var.volume
    volume_type = var.volume_type
  }
}