############################
# Variables del API Gateway
############################

# Nombre y configuración del API Gateway HTTP
variable "apigateway_http_name" {
  description = "Nombre del API Gateway HTTP."
  type        = string
}

variable "apigateway_http_tags" {
  description = "Mapa de etiquetas adicionales para el API Gateway HTTP."
  type        = map(string)
  default     = {}
}

variable "route_selection_expression" {
  description = "Expresión de selección de rutas del API Gateway HTTP."
  type        = string
  default     = "$request.method $request.path"
}

############################
# Variables del Autorizador Cognito
############################

variable "cognito_authorizer_name" {
  description = "Nombre del autorizador Cognito."
  type        = string
}

variable "cognito_identity_sources" {
  description = "Fuentes de identidad para el autorizador Cognito."
  type        = list(string)
  default     = ["$request.header.Authorization"]
}

variable "cognito_audience" {
  description = "Audiencia permitida para los tokens JWT en Cognito."
  type        = list(string)
}

variable "cognito_issuer" {
  description = "URL del emisor de los tokens JWT (Cognito User Pool)."
  type        = string
}

############################
# Variables de Integración Lambda
############################

variable "lambda_integration_uri" {
  description = "URI de la Lambda para integrarla con el API Gateway."
  type        = string
}

variable "integration_timeout_milliseconds" {
  description = "Tiempo de espera en milisegundos para la integración Lambda."
  type        = number
  default     = 30000
}

############################
# Variables de Rutas
############################

variable "default_route_key" {
  description = "Clave de la ruta predeterminada del API Gateway."
  type        = string
  default     = "ANY /"
}

############################
# Variables del WAF
############################

variable "waf_arn" {
  description = "ARN del WAF asociado al API Gateway."
  type        = string
}
