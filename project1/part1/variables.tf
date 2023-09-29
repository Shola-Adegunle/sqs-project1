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
