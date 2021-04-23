resource "aws_iam_role" "lambda_iam" {
  name = "lambda_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "encrypt" {
  filename         = "encrypt.zip"
  function_name    = "encrypt"
  role             = aws_iam_role.lambda_iam.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("encrypt.zip")
  runtime          = var.runtime
}

resource "aws_lambda_function" "decrypt" {
  filename         = "decrypt.zip"
  function_name    = "decrypt"
  role             = aws_iam_role.lambda_iam.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("decrypt.zip")
  runtime          = var.runtime
}

resource "aws_iam_role_policy_attachment" "dynamo" {
  role       = aws_iam_role.lambda_iam.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda_iam.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.lambda_iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}