output "lambda_arn" {
  description = "ARN de la función Lambda creada."
  value       = aws_lambda_function.lambda.arn
}

output "lambda_name" {
  description = "Nombre de la función Lambda creada."
  value       = aws_lambda_function.lambda.function_name
}

output "lambda_execution_role_arn" {
  description = "ARN del rol de ejecución de Lambda creado."
  value       = aws_iam_role.lambda_execution_role.arn
}