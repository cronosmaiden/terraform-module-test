############################
# Outputs del API Gateway REST
############################

# ARN de ejecución del API Gateway REST
output "api_gateway_execution_arn" {
  description = "ARN de ejecución del API Gateway REST creado."
  value       = aws_api_gateway_rest_api.rest_api.execution_arn
}

# URL del endpoint del API Gateway REST
output "api_gateway_endpoint" {
  description = "URL del endpoint del API Gateway REST."
  value       = aws_api_gateway_deployment.rest_deployment.invoke_url
}

# ID del API Gateway REST creado
output "api_gateway_id" {
  description = "ID del API Gateway REST creado."
  value       = aws_api_gateway_rest_api.rest_api.id
}

# Exportar el ARN del stage (prod) para WAF
output "api_gateway_stage_arn" {
  description = "ARN de la etapa 'prod' del API Gateway REST."
  value       = aws_api_gateway_stage.prod_stage.arn
}
