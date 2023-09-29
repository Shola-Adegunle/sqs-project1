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