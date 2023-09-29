///////////////////////////////////////////////////////////////
## SQS QUEUE
###############################################################
resource "aws_sqs_queue" "terraform_queue" {
  name                      = var.sqs_queue_name
  delay_seconds             = 90    # Configure the delay before messages become available (in seconds)
  max_message_size          = 2048  # Set the maximum size of messages that can be sent to the queue (in bytes)
  message_retention_seconds = 86400 # Configure the time (in seconds) that messages are retained in the queue
  receive_wait_time_seconds = 10    # Configure the time (in seconds) the queue waits for incoming messages

  # Define a redrive policy, which specifies the Dead Letter Queue (DLQ)
  # where messages that have been received and processed a certain number of times
  # will be sent to. This helps in handling failed messages.

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = var.sqs_queue_environment
  }
}

///////////////////////////////////////////////////////////////
## DEAD LETTER QUEUE
///////////////////////////////////////////////////////////////
resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = var.sqs_queue_name_deadletter
}


///////////////////////////////////////////////////////////////
## QUEUE ENCRYPTION
///////////////////////////////////////////////////////////////
resource "aws_sqs_queue" "terraform_queue_encryption" {
  name                    = var.sqs_queue_name_encryption
  sqs_managed_sse_enabled = true
}

///////////////////////////////////////////////////////////////
// Define the Policy for the SQS Queue
///////////////////////////////////////////////////////////////
resource "aws_sqs_queue_policy" "terraform_queue_policy" {
  queue_url = aws_sqs_queue.terraform_queue.id

  ///////////////////////////////////////////////////////////////
  ## policy document that specifies who can send messages to this queue
  ///////////////////////////////////////////////////////////////
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowSendMessage"
        Effect    = "Allow"
        Principal = "*"
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.terraform_queue.arn
      }
    ]
  })
}