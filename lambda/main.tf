resource "aws_lambda_function" "lambda" {
  function_name                  = var.lambda_function_name
  role                           = var.lambda_function_role == null ? aws_iam_role.lambda_execution_role.arn : var.lambda_function_role
  runtime                        = var.lambda_function_runtime
  filename                       = var.lambda_function_filename
  handler                        = var.lambda_function_handler
  architectures                  = [var.lambda_function_architecture]
  memory_size                    = var.lambda_function_memory
  timeout                        = var.lambda_function_timeout
  description                    = var.lambda_function_description
  environment {
    variables = var.lambda_function_environment_variables
  }
  tags = var.lambda_function_additional_tags

  vpc_config {
    security_group_ids = var.lambda_function_security_group == [""] ? null : var.lambda_function_security_group
    subnet_ids         = var.lambda_function_subnet_ids == [""] ? null : var.lambda_function_subnet_ids
  }

  ephemeral_storage {
    size = var.lambda_function_ephemeral_storage
  }

  tracing_config {
    mode = var.lambda_function_tracing_config_mode
  }

  lifecycle {
    ignore_changes = [
      layers,
      snap_start,
      filename,
      publish
    ]
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.api_gateway_source_arn
}
