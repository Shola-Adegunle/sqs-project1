# Terraform AWS Project

This project uses Terraform to deploy a VPC, subnets, an internet gateway, routing tables, and EC2 instances in AWS.

## Resources Created

1. **VPC**: A VPC is created with the given CIDR block.
2. **Availability Zones**: Retrieves the availability zones for the region.
3. **Subnets**: Public subnets are created within the VPC across the availability zones.
4. **Routing Table**: A public routing table is created and associated with the public subnets.
5. **Internet Gateway**: An internet gateway is attached to the VPC to allow the instances to access the internet.
6. **EC2 Instances**: EC2 instances are launched in the public subnets with a security group allowing HTTP, HTTPS, and SSH access.
7. **Lambda Function**: A Lambda function is deployed to produce messages to an SQS queue.
8. **Security Groups**: Security groups for allowing HTTP, HTTPS, and SSH traffic to the EC2 instances.
9. **IAM Roles and Policies**: IAM roles and policies for EC2 instances and Lambda function to access the SQS queue.

## Outputs

- `vpc_id`: The ID of the VPC.
- `availability_zones`: The availability zones.
- `public_subnet_ids`: The IDs of the public subnets.
- `public_route_table_id`: The ID of the public route table.
- `route_table_association_ids`: The IDs of the route table associations.
- `internet_gateway_id`: The ID of the Internet Gateway.
- `ami_id`: The ID of the Amazon Machine Image (AMI).
- `ec2_instance_ids`: The IDs of the EC2 instances.
- `ec2_instance_public_ips`: The public IPs of the EC2 instances.
- `lambda_function_name`: The name of the Lambda function.
- `security_group_http_id`: The ID of the HTTP security group.
- `security_group_ssh_id`: The ID of the SSH security group.
- `sqs_queue_url`: The URL of the SQS queue.
- `iam_role_ec2_sqs_name`: The name of the IAM role for EC2 SQS.
- `iam_instance_profile_name`: The name of the IAM instance profile.
- `lambda_iam_role_name`: The name of the IAM role for Lambda.

## Usage

1. Clone the repository.
2. Navigate to the project directory.
3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform apply` to apply the configuration and create the resources in AWS.

**Note:** Ensure that you have valid AWS credentials configured in your environment to allow Terraform to create resources in your AWS account.

## Cleanup

To delete all the resources created by Terraform, run the following command:

```bash
terraform destroy
