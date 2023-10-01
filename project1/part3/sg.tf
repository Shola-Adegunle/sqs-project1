resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH on private EC2 web instances"
  vpc_id      = aws_vpc.vpc-lab11.id

  ingress {
    description = "SSH to web instances"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr] # # restricted further to a few known IP addresses

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]

  }

  tags = {
    Name = "allow_ssh-${var.project}-${var.environment}"
  }
}

