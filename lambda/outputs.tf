output "lambda_arn" {
  description = "ARN de la función Lambda creada."
  value       = aws_lambda_function.lambda.arn
}

output "lambda_name" {
  description = "Nombre de la función Lambda creada."
  value       = aws_lambda_function.lambda.function_name
}
