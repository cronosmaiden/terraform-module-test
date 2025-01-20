############################
# Variables del API Gateway REST
############################

# Nombre y configuración del API Gateway REST
variable "apigateway_rest_name" {
  description = "Nombre del API Gateway REST."
  type        = string
  default     = "my-default-rest-api"
}

variable "apigateway_rest_description" {
  description = "Descripción del API Gateway REST."
  type        = string
  default     = "API Gateway REST para la integración con Lambda."
}

variable "apigateway_rest_tags" {
  description = "Mapa de etiquetas adicionales para el API Gateway REST."
  type        = map(string)
  default     = {}
}

############################
# Variables de Integración Lambda
############################

variable "lambda_integration_uri" {
  description = "URI de la Lambda para integrarla con el API Gateway REST."
  type        = string
}

variable "lambda_integration_http_method" {
  description = "Método HTTP usado para integrar la Lambda con el API Gateway REST."
  type        = string
  default     = "POST"
}

############################
# Variables de Rutas
############################

variable "default_route_path_part" {
  description = "Parte del path para el recurso base del API Gateway REST."
  type        = string
  default     = "default" # Ajusta según sea necesario
}

############################
# Variables del WAF
############################

variable "waf_arn" {
  description = "ARN del WAF asociado al API Gateway REST."
  type        = string
}

variable "region" {
  description = "Región donde se desplegarán los recursos del API Gateway REST."
  type        = string
}
