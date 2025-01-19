############################
# Outputs del API Gateway
############################

output "api_gateway_execution_arn" {
  description = "ARN de ejecución del API Gateway creado."
  value       = aws_apigatewayv2_api.http_api.execution_arn
}

output "api_gateway_endpoint" {
  description = "URL del endpoint del API Gateway."
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

output "api_gateway_id" {
  description = "ID del API Gateway creado."
  value       = aws_apigatewayv2_api.http_api.id
}

# Exportar el ARN de la etapa (prod)
output "api_gateway_stage_arn" {
  description = "ARN de la etapa 'prod' del API Gateway en formato válido para WAF."
  value       = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_apigatewayv2_api.http_api.id}/${aws_apigatewayv2_stage.prod_stage.name}"
}