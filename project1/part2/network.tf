///////////////////////////////////////////
### VCP ###
///////////////////////////////////////////
resource "aws_vpc" "vpc-lab11" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = {
    Name = "vpc-${var.project}-${var.environment}"
  }
}

///////////////////////////////////////////
### AVAILABILITY ZONE ###
///////////////////////////////////////////#
data "aws_availability_zones" "available" {
  state = "available"
}

///////////////////////////////////////////
### PUBLIC SUBNETS ###
///////////////////////////////////////////
resource "aws_subnet" "public_subnet" {
  count             = var.subnet_count
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.vpc-lab11.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 1) # function adds 8 bits to cidr = 24 and starts host subnet from 1 using count.index

  tags = {
    Name = "public-subnet-${var.environment}-${count.index + 1}"
  }
}

///////////////////////////////////////////
### PUBLIC ROUTE ###
///////////////////////////////////////////
resource "aws_route_table" "public_rt" { # private route to the IGW
  vpc_id = aws_vpc.vpc-lab11.id

  route {
    cidr_block = var.default_cidr_route
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt${var.project}-${var.environment}}"
  }
}

///////////////////////////////////////////
### ASSOCIATION ###
///////////////////////////////////////////
resource "aws_route_table_association" "public_rta" {
  count          = var.rt_count
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet[count.index].id ##  need to associate to all subnets ### can only specify a gateway id or a subnet but not both ###
}


///////////////////////////////////////////
### INTERNET GATEWAY ###
///////////////////////////////////////////
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-lab11.id

  tags = {
    Name = "IGW-${var.project}-${var.environment}"
  }
}
