Certainly! Below is an updated README.md file.

---

# AWS Messaging Project using Terraform

This project utilizes Terraform for deploying essential AWS resources like VPC, subnets, EC2 instances, and SQS queues.

## 🚀 Resources Created

1. **VPC**: Sets up a VPC with a specified CIDR block.
2. **Availability Zones**: Determines the availability zones within the region.
3. **Subnets**: Establishes private subnets within the VPC across availability zones.
4. **EC2 Instances**: Launches EC2 instances in the private subnets, allowing SSH access via security groups.
5. **Lambda Function**: Deploys a Lambda function to produce messages for an SQS queue.
6. **Security Groups**: Enables SSH traffic to the EC2 instances.
7. **IAM Roles and Policies**: Provides IAM roles and policies enabling EC2 and Lambda to access the SQS queue.
8. **SQS Queue**: Creates an SQS queue with configurable settings.
9. **Dead Letter Queue**: Handles failed messages through a dead letter queue.
10. **Queue Encryption**: Ensures the SQS queue is encrypted.
11. **Queue Policy**: Defines a policy detailing who can send messages to the queue.

## 📤 Outputs

- `vpc_id`: The created VPC's ID.
- `availability_zones`: The used availability zones.
- `private_subnet_ids`: IDs of the private subnets.
- `ami_id`: ID of the utilized Amazon Machine Image (AMI).
- `ec2_instance_ids`: IDs of the EC2 instances.
- `ec2_instance_public_ips`: Public IPs of the EC2 instances.
- `lambda_function_name`: Name of the deployed Lambda function.
- `security_group_ssh_id`: ID of the SSH security group.
- `sqs_queue_url`: URL of the SQS queue.
- `iam_role_ec2_sqs_name`: Name of the IAM role for EC2 SQS.
- `iam_instance_profile_name`: Name of the IAM instance profile.
- `lambda_iam_role_name`: Name of the IAM role for Lambda.

## 🛠️ Usage

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Initialize the Terraform configuration by running `terraform init`.
4. Apply the configuration and establish the resources in AWS with `terraform apply`.

## ⚠️ Note

Ensure your environment is configured with valid AWS credentials, allowing Terraform to perform operations on your AWS account.

---
