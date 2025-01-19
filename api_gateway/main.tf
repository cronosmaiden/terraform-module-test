############################
# API Gateway HTTP (v2)
############################

# Crear la API Gateway HTTP
resource "aws_apigatewayv2_api" "http_api" {
  name          = var.apigateway_http_name
  protocol_type = "HTTP"

  # Expresión de selección de ruta
  route_selection_expression = var.route_selection_expression

  # Tags para trazabilidad
  tags = var.apigateway_http_tags
}

############################
# Autorizador Cognito
############################

# Crear el autorizador de Cognito para la API Gateway
resource "aws_apigatewayv2_authorizer" "cognito_authorizer" {
  depends_on   = [aws_apigatewayv2_api.http_api]
  name         = var.cognito_authorizer_name
  api_id       = aws_apigatewayv2_api.http_api.id
  authorizer_type = "JWT"

  # Configuración del grupo de usuarios de Cognito
  identity_sources = var.cognito_identity_sources
  jwt_configuration {
    audience = var.cognito_audience
    issuer   = var.cognito_issuer
  }
}

############################
# Integración Lambda
############################

# Configurar la integración entre API Gateway y Lambda
resource "aws_apigatewayv2_integration" "lambda_integration" {
  depends_on = [var.lambda_integration_uri]
  api_id      = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"

  # ARN de la función Lambda a integrar
  integration_uri = var.lambda_integration_uri

  # Configuración adicional de integración
  payload_format_version = "2.0"
  timeout_milliseconds   = var.integration_timeout_milliseconds
}

############################
# Configurar Rutas
############################

# Ruta principal que apunta a la integración Lambda
resource "aws_apigatewayv2_route" "default_route" {
  depends_on = [aws_apigatewayv2_integration.lambda_integration]
  api_id     = aws_apigatewayv2_api.http_api.id
  route_key  = var.default_route_key
  target     = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

############################
# Configurar WAF (Asociación)
############################

# Asociar un WAF a la API Gateway
resource "aws_wafv2_web_acl_association" "waf_association" {
  depends_on = [aws_apigatewayv2_api.http_api]
  resource_arn = aws_apigatewayv2_api.http_api.execution_arn
  web_acl_arn  = var.waf_arn
}
