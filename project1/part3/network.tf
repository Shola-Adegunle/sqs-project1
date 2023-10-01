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
///////////////////////////////////////////
data "aws_availability_zones" "available" {
  state = "available"
}

///////////////////////////////////////////
### PRIVATE SUBNETS ###
///////////////////////////////////////////
resource "aws_subnet" "private_subnet" {
  count             = var.subnet_count
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.vpc-lab11.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 1) # function adds 8 bits to cidr = 24 and starts host subnet from 1 using count.index

  tags = {
    Name = "private-subnet-${var.project}-${var.environment}-${count.index + 1}"
  }
}




