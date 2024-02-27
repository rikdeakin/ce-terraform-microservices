resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

#####
### Internet Gateway 
#####

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "${var.vpc_name}-igw"
    ManagedBy = "Terraform"
  }
}

######
### Subnet definitions
######

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[0]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name      = "${var.vpc_name}-public-sn"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name      = "${var.vpc_name}-private-sn"
    ManagedBy = "Terraform"
  }
}

######
## Public Routes
######

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "${var.vpc_name}-public"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "${var.vpc_name}-private"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


