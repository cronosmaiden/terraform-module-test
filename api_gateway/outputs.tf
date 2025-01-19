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