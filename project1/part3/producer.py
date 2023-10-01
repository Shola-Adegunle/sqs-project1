import os
import boto3

def lambda_handler(event, context):
    sqs = boto3.client('sqs')
    queue_url = os.environ['QUEUE_URL']
    message = 'Hello, World!'
    response = sqs.send_message(
        QueueUrl=queue_url,
        MessageBody=message
    )
    return response
