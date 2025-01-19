############################
# AWS IAM Role para Lambda
############################

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role-new2"

  # Permitir que Lambda asuma este rol
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  lifecycle {
    ignore_changes = [name]
  }
}

# Adjuntar la política básica de ejecución para Lambda
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
