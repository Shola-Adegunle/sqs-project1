#################################################################
# EC2 IMAGE
#################################################################
data "aws_ami" "amz-linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

#################################################################
# EC2 WEB INSTANCES
#################################################################
resource "aws_instance" "ec2_sqs" {
  count                  = var.instance_count
  ami                    = data.aws_ami.amz-linux2.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = var.private_web_subnet[count.index]
  vpc_security_group_ids = [var.allow_http_sg, var.allow_ssh_sg] #var.security_group_ids
  tenancy                = "default"
  user_data              = file("scripts/apache.sh") # this will read the user data from my script location 

  tags = {
    Name = "EC2 Web-${var.project}-${var.environment}-${count.index + 1}"
  }

}


