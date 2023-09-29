///////////////////////////////////////////
### SG FOR EC2 INSTANCES ###
///////////////////////////////////////////
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic on private EC2 web instances"
  vpc_id      = aws_vpc.vpc-lab11.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-lab11.cidr_block] # can specify web instances cidr's 

  }

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-lab11.cidr_block] # can specify web instances cidr's 

  }

  ingress {
    description = "SSH to web instances"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-lab11.cidr_block] # can specify web instances cidr's 

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_http and https"
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH on private EC2 web instances"
  vpc_id      = aws_vpc.vpc-lab11.id

  ingress {
    description = "SSH to web instances"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-lab11.cidr_block] # can specify web instances cidr's 

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_ssh${var.project}-${var.environment}"
  }
}

