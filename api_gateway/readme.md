# Módulo API Gateway - Terraform

Este módulo crea un **API Gateway HTTP** en AWS con integración a Lambda, autorizador Cognito y asociación a WAF.

## Requisitos

- Terraform v1.5.2
- Provider AWS v5.45.0

## Variables

### API Gateway HTTP
- `apigateway_http_name`: Nombre del API Gateway HTTP (string, requerido).
- `apigateway_http_tags`: Mapa de etiquetas para el API Gateway HTTP (mapa, opcional).
- `route_selection_expression`: Expresión de selección de rutas (string, opcional, por defecto: `"$request.method $request.path"`).

### Autorizador Cognito
- `cognito_authorizer_name`: Nombre del autorizador Cognito (string, requerido).
- `cognito_identity_sources`: Fuentes de identidad para Cognito (lista, opcional).
- `cognito_audience`: Audiencia permitida para JWT (lista, requerido).
- `cognito_issuer`: URL del emisor de los tokens JWT (string, requerido).

### Integración Lambda
- `lambda_integration_uri`: URI de la Lambda integrada con el API Gateway (string, requerido).
- `integration_timeout_milliseconds`: Tiempo de espera para la integración Lambda (número, opcional).

### WAF
- `waf_arn`: ARN del WAF asociado al API Gateway (string, opcional).

## Outputs

- `api_gateway_id`: ID del API Gateway creado.
- `api_gateway_endpoint`: URL del endpoint del API Gateway.
- `cognito_authorizer_id`: ID del autorizador Cognito.

## Ejemplo de Uso

```hcl
module "api_gateway" {
  source = "./api_gateway"

  apigateway_http_name           = "my-http-api"
  cognito_authorizer_name        = "my-cognito-authorizer"
  cognito_audience               = ["my-client-id"]
  cognito_issuer                 = "https://cognito-idp.<region>.amazonaws.com/<user-pool-id>"
  lambda_integration_uri         = "arn:aws:lambda:<region>:<account-id>:function:<function-name>"
  waf_arn                        = "arn:aws:wafv2:..."
}
