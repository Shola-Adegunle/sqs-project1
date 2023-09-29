resource "aws_lambda_function" "producer" {
  function_name = "producer"
  handler       = "producer.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_role.arn
  filename      = "producer.zip"
  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.terraform_queue.url
    }
  }
}