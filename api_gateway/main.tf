############################
# API Gateway REST (v1)
############################

# Obtener información de la cuenta actual
data "aws_caller_identity" "current" {}

# Crear la API Gateway REST
resource "aws_api_gateway_rest_api" "rest_api" {
  name        = var.apigateway_rest_name
  description = var.apigateway_rest_description

  # Tags para trazabilidad
  tags = var.apigateway_rest_tags
}

# Crear un recurso base (root) en el API Gateway
resource "aws_api_gateway_resource" "root_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = var.default_route_path_part
}

# Integración Lambda
resource "aws_api_gateway_method" "lambda_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.root_resource.id
  http_method   = var.lambda_integration_http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.root_resource.id
  http_method = aws_api_gateway_method.lambda_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_integration_uri
}

# Crear el stage para desplegar el API
resource "aws_api_gateway_deployment" "rest_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  description = "Deployment for REST API"
}

# Crear el stage asociado al deployment
resource "aws_api_gateway_stage" "prod_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  deployment_id = aws_api_gateway_deployment.rest_deployment.id
  description   = "Production stage"
}

############################
# Configurar WAF (Asociación)
############################

# Asociar un WAF al API Gateway REST
resource "aws_wafv2_web_acl_association" "waf_association" {
  
  resource_arn = aws_api_gateway_stage.prod_stage.arn
  web_acl_arn  = var.waf_arn
}
