variable "sqs_queue_name" {
  default = "terraform-sqs-queue"
}

variable "sqs_queue_name_deadletter" {
  default = "terraform-deadletter-queue"
}

variable "sqs_queue_name_encryption" {
  default = "terraform-encryption-queue"
}

variable "sqs_queue_environment" {
  default = "dev"
}



//////////////////////////////
### ENVIRONMENT VARIABLES ###
//////////////////////////////
variable "project" {
  default = "project2"
}

variable "environment" {
  default = "dev"
}

variable "default_region" {
  default = "east-us-1"
}

//////////////////////////////
## VPC VARIABLES
/////////////////////////////
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "dns_hostnames" {
  default = "true"
}

variable "instance_tenancy" {
  default = "default"
}

//////////////////////////////
## SUBNET VARIABLES
/////////////////////////////
variable "subnet_count" {
  default = 2
}


//////////////////////////////
## ROUTE TABLE VARIABLES
/////////////////////////////
variable "rt_count" {
  default = 2
}
variable "default_cidr_route" {
  default = "0.0.0.0/0"
}


//////////////////////////////
## INSTANCE VARIABLES
/////////////////////////////
variable "instance_count" {
  default = 2
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair_name" {
  type        = string
  description = "private key name"
  default     = "TerraformLabs2"
  sensitive   = true
}
