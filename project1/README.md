# Terraform AWS SQS Projects

This repository contains three Terraform projects related to Amazon Simple Queue Service (SQS). Each project focuses on different aspects of working with SQS and demonstrates how to use Terraform to provision and manage AWS resources effectively.

## Project 1: Creating an SQS Queue

**Objective:** This project focuses on creating a simple SQS queue using Terraform.

**Description:**

In this project, you will use Terraform to create an Amazon SQS queue. This queue will serve as a messaging system that allows you to send and receive messages between different components of an application. You will define the queue's properties, such as its name and any access policies, and provision it using Terraform. This project is an excellent starting point to get familiar with basic SQS configurations and Terraform resource definitions.

**Key Tasks:**

- Create an SQS queue with a specific name.
- Define access policies for the queue.
- Use Terraform to provision the resources on AWS.

## Project 2: Producer and Consumer for SQS Queue

**Objective:** This project focuses on building a complete workflow involving message producers and consumers using SQS.

**Description:**

In this project, you will create an SQS queue as in the first project but then go further by implementing message producers and consumers. You'll use AWS Lambda functions as message producers and EC2 instances as message consumers. AWS Lambda functions will periodically send messages to the SQS queue, and EC2 instances will poll the queue for messages and process them. This project demonstrates how to set up a fully functional messaging system using SQS and Terraform.

**Key Tasks:**

- Create an SQS queue.
- Create AWS Lambda functions to act as message producers.
- Launch EC2 instances as message consumers.
- Implement polling logic in the EC2 instances to retrieve and process messages from the SQS queue.
- Define Terraform configurations for all these resources and their dependencies.

## Project 3: Auto-Scaling SQS Consumers

**Objective:** This project focuses on dynamically scaling the number of consumers based on SQS queue length.

**Description:**

In this project, you will extend the previous project by integrating AWS Auto Scaling. You will configure an Auto Scaling group for the EC2 instances that act as message consumers. The Auto Scaling group will monitor the length of the SQS queue using CloudWatch metrics. If the queue length increases beyond a certain threshold, the Auto Scaling group will automatically add more EC2 instances to handle the increased workload. Conversely, if the queue length decreases, it will scale down the number of instances. This project demonstrates how to create a scalable architecture that can adapt to varying message loads using Terraform and AWS services.

**Key Tasks:**

- Build upon the previous project's setup with message producers and consumers.
- Configure an Auto Scaling group for EC2 instances.
- Define CloudWatch alarms to trigger scaling actions based on SQS queue length.
- Implement Terraform configurations to set up Auto Scaling and related resources.

Each of these projects will provide you with hands-on experience in working with SQS and Terraform while addressing different aspects of message queuing and scaling.