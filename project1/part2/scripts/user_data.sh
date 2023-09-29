#!/bin/bash
while true; do
  message=$(aws sqs receive-message --queue-url ${queue_url} --max-messages 1 --visibility-timeout 10 --wait-time-seconds 10)
  receipt_handle=$(aws sqs receive-message --queue-url ${queue_url} --max-messages 1 --visibility-timeout 10 --wait-time-seconds 10 --query 'Messages[0].ReceiptHandle' --output text)
  if [[ "$receipt_handle" != "None" ]]; then
    # Process the message here
    echo "Message received: $message"
    # Delete the message from the queue after processing
    aws sqs delete-message --queue-url ${queue_url} --receipt-handle "$receipt_handle"
  fi
  sleep 5
done
