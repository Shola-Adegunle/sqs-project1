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
# EC2 ASG
///////////////////////////////////////////
resource "aws_launch_configuration" "ec2-lc" {
  image_id             = data.aws_ami.amz-linux2.id
  instance_type        = var.instance_type
  key_name             = var.key_pair_name
  user_data            = templatefile("scripts/user_data.sh", { QUEUE_URL = aws_sqs_queue.terraform_queue.url })
  iam_instance_profile = aws_iam_instance_profile.ec2_sqs_profile.name
  security_groups      = [aws_security_group.allow_ssh.id]
  placement_tenancy    = var.instance_tenancy

}


resource "aws_autoscaling_group" "ec2_asg" {
  name             = "asg-${var.project}-${var.environment}"
  desired_capacity = 2 // Set to 2 to launch two instances initially
  min_size         = 2
  max_size         = 3

  launch_configuration = aws_launch_configuration.ec2-lc.name
  vpc_zone_identifier  = aws_subnet.private_subnet[*].id //  is defined as a list of subnet resources

  health_check_grace_period = 60    // he length of time that Auto Scaling waits before checking the health status of an instance
  wait_for_capacity_timeout = "0"   //  to skip waiting for the desired capacity
  health_check_type         = "EC2" // using EC2 status checks

  tag {
    key                 = "Name"
    value               = "EC2-ASG-${var.project}-${var.environment}"
    propagate_at_launch = true
  }

}

