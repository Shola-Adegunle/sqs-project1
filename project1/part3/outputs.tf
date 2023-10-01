///////////////////////////////////////////////////////////////
## QUEUE OUTPUTS
///////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////
## NETWORK OUTPUTS
///////////////////////////////////////////////////////////////
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc-lab11.id
}

output "availability_zones" {
  description = "The availability zones"
  value       = data.aws_availability_zones.available.names
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnet[*].id
}


///////////////////////////////////////////////////////////////
## INSTANCE OUTPUTS
///////////////////////////////////////////////////////////////
output "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI)"
  value       = data.aws_ami.amz-linux2.id
}

output "ec2_instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.ec2_sqs[*].id
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.producer.function_name
}

