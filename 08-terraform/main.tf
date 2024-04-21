module "vpc-test" {
  source = "./modules/vpc"
  cidr_block = "192.168.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support = true

  tagName = "vpc-test"
  tagEnvironment = "development"
  tagProject = "mifx"
}

module "subnet-01" {
  source = "./modules/subnet"
  subnet_name = "public_01"
  pub_subnet_cidr_block = "192.168.1.0/24"
  vpc_id = module.vpc-test.vpc_id
  zone = "ap-northeast-2a"
}

module "subnet-02" {
  source = "./modules/subnet"
  subnet_name = "public_02"
  pub_subnet_cidr_block = "192.168.2.0/24"
  vpc_id = module.vpc-test.vpc_id
  zone = "ap-northeast-2b"
}

module "subnet-03" {
  source = "./modules/subnet"
  subnet_name = "private_01"
  pub_subnet_cidr_block = "192.168.3.0/24"
  vpc_id = module.vpc-test.vpc_id
  zone = "ap-northeast-2b"
}

module "nat-01" {
  source = "./modules/nat"
  subnet_id = module.subnet-02.subnet_id
  tagName = "nat-test"
  tagEnvironment = "development"
  tagProject = "mifx"
}

module "route-table" {
  source = "./modules/rt"
  tagName = "rt-test"
  tagEnvironment = "development"
  tagProject = "mifx"
  nat_gateway_id = module.nat-01.nat_gateway_id
  igw_id = module.vpc-test.igw_id
  vpc_id = module.vpc-test.vpc_id
  # depends_on = [ module.nat-01, module.vpc-test ]

}

resource "aws_route_table_association" "public_associate_01" {
  route_table_id = module.route-table.rt_public_id
  subnet_id = module.subnet-01.subnet_id
  # depends_on = [ module.route-table ]
}

resource "aws_route_table_association" "public_associate_02" {
  route_table_id = module.route-table.rt_public_id
  subnet_id = module.subnet-02.subnet_id
  # depends_on = [ module.route-table ]
}

resource "aws_route_table_association" "private_associate_01" {
  route_table_id = module.route-table.rt_private_id
  subnet_id = module.subnet-03.subnet_id
  # depends_on = [ module.route-table ]
}

module "ec2-01" {
  source = "./modules/ec2"
  subnet_id = module.subnet-03.subnet_id
  ec2_type = "t3.medium"
  ami = "ami-0c55b159cbfafe1f0"
  volume = 40
  volume_type = "gp2"
  
}