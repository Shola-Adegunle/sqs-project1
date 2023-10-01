///////////////////////////////////////////
### LAMBDA RESOURCE ###
///////////////////////////////////////////
resource "aws_lambda_function" "producer" {
  function_name = "producer"
  handler       = "producer.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_sqs_role.arn
  filename      = "producer.zip"
  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.terraform_queue.url
    }
  }
}


///////////////////////////////////////////
### LAMBDA ROLE ###
///////////////////////////////////////////
resource "aws_iam_role" "lambda_sqs_role" {
  name = "lambda_sqs_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

///////////////////////////////////////////
### LAMBDA POLICY ###
///////////////////////////////////////////
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_sqs_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "sqs:SendMessage"
      ],
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}