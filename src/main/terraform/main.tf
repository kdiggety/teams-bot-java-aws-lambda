resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "teams_bot_lambda" {
  function_name = "TeamsBotLambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "com.company.bot.lambda.TeamsBotHandler::handleRequest"
  runtime       = "java17"
  timeout       = 30
  memory_size   = 512

  filename         = var.lambda_jar_path
  source_code_hash = filebase64sha256(var.lambda_jar_path)

  environment {
    variables = {
      TEAMS_BOT_TOKEN = var.teams_bot_token
    }
  }
}
