############################
# Outputs del API Gateway
############################

output "api_gateway_id" {
  description = "ID del API Gateway creado."
  value       = aws_apigatewayv2_api.http_api.id
}

output "api_gateway_endpoint" {
  description = "URL del endpoint del API Gateway."
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

output "cognito_authorizer_id" {
  description = "ID del autorizador Cognito asociado al API Gateway."
  value       = aws_apigatewayv2_authorizer.cognito_authorizer.id
}
