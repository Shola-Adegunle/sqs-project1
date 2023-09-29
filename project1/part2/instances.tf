///////////////////////////////////////////
# EC2 IMAGE
///////////////////////////////////////////
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


///////////////////////////////////////////
# EC2 CREATE AN IAM ROLE AND ASSIGN
///////////////////////////////////////////
resource "aws_iam_role" "ec2_sqs_role" {
  name = "ec2_sqs_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
    }],
  })
}

resource "aws_iam_role_policy_attachment" "sqs_full_access" {
  role       = aws_iam_role.ec2_sqs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_instance_profile" "ec2_sqs_profile" {
  name = "ec2_sqs_profile"
  role = aws_iam_role.ec2_sqs_role.name
}

///////////////////////////////////////////
# EC2 WEB INSTANCES
///////////////////////////////////////////
resource "aws_instance" "ec2_sqs" {
  count                  = var.instance_count
  ami                    = data.aws_ami.amz-linux2.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.public_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_http.id, aws_security_group.allow_ssh.id] #var.security_group_ids
  tenancy                = "default"
  iam_instance_profile   = aws_iam_instance_profile.ec2_sqs_profile.name
  user_data              = templatefile("scripts/user_data.sh", { queue_url = aws_sqs_queue.terraform_queue.url }) # this will read the user data from my script location 

  tags = {
    Name = "EC2 Web-${var.project}-${var.environment}-${count.index + 1}"
  }

}
