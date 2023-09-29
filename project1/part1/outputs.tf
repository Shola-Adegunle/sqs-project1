output "queue_url" {
  description = "URL of the main SQS queue"
  value       = aws_sqs_queue.terraform_queue.id
}

output "queue_arn" {
  description = "ARN of the main SQS queue"
  value       = aws_sqs_queue.terraform_queue.arn
}

output "dead_letter_queue_url" {
  description = "URL of the Dead Letter Queue (DLQ)"
  value       = aws_sqs_queue.terraform_queue_deadletter.id
}

output "queue_encryption_status" {
  description = "SQS Queue Encryption Status"
  value       = aws_sqs_queue.terraform_queue_encryption.kms_master_key_id
}

output "queue_policy" {
  description = "Policy attached to the main SQS queue"
  value       = aws_sqs_queue_policy.terraform_queue_policy.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc-lab11.id
}

output "availability_zones" {
  description = "The availability zones"
  value       = data.aws_availability_zones.available.names
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnet[*].id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rt.id
}

output "route_table_association_ids" {
  description = "The IDs of the route table associations"
  value       = aws_route_table_association.public_rta[*].id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI)"
  value       = data.aws_ami.amz-linux2.id
}

output "ec2_instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.ec2_sqs[*].id
}

output "ec2_instance_public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = aws_instance.ec2_sqs[*].public_ip
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.producer.function_name
}

output "security_group_http_id" {
  description = "The ID of the HTTP security group"
  value       = aws_security_group.allow_http.id
}

output "security_group_ssh_id" {
  description = "The ID of the SSH security group"
  value       = aws_security_group.allow_ssh.id
}
