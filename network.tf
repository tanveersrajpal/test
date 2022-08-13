resource "aws_vpc" "vpc-main" {
  cidr_block           = "172.80.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
}

resource "aws_subnet" "prod-subnet-public-1" {
  vpc_id                  = aws_vpc.vpc-main.id
  cidr_block              = "172.80.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = var.vpc_subnet_az_a
  tags = {
    CreatedBy = "Tanveer"
  }
}

resource "aws_subnet" "prod-subnet-public-2" {
  vpc_id                  = aws_vpc.vpc-main.id
  cidr_block              = "172.80.32.0/20"
  map_public_ip_on_launch = true
  availability_zone       = var.vpc_subnet_az_b
  tags = {
    CreatedBy = "Tanveer"
  }
}

resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.vpc-main.id
  tags = {
    CreatedBy = "Tanveer"
  }
}

# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc-main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }
  tags = {
    Name = "publicRouteTable"
  }
}
# Route table association with public subnets
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod-subnet-public-1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.prod-subnet-public-2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.vpc-main.id
  route_table_id = aws_route_table.public_rt.id
}
