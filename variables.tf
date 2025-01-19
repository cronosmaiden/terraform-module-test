############################
# Variables globales
############################

variable "region" {
  description = "Región de AWS para desplegar los recursos."
  type        = string
  default     = "us-east-1"
}

############################
# Variables de Lambda
############################

variable "lambda_function_name" {
  description = "Nombre de la función Lambda."
  type        = string
}

variable "lambda_function_role" {
  description = "ARN del rol de ejecución de la Lambda."
  type        = string
}

variable "lambda_function_runtime" {
  description = "Runtime de la Lambda (por ejemplo, python3.9)."
  type        = string
  default     = "python3.9"
}

variable "lambda_function_filename" {
  description = "Ruta del archivo ZIP con el código de la Lambda."
  type        = string
}

variable "lambda_function_handler" {
  description = "Nombre del archivo y método handler de la Lambda."
  type        = string
}

variable "lambda_function_architecture" {
  description = "Arquitectura de la Lambda (x86_64 o arm64)."
  type        = string
  default     = "x86_64"
}

variable "lambda_function_memory" {
  description = "Cantidad de memoria asignada a la Lambda (en MB)."
  type        = number
  default     = 128
}

variable "lambda_function_timeout" {
  description = "Tiempo máximo de ejecución de la Lambda (en segundos)."
  type        = number
  default     = 10
}

variable "lambda_function_description" {
  description = "Descripción de la función Lambda."
  type        = string
  default     = ""
}

variable "lambda_function_environment_variables" {
  description = "Mapa de variables de entorno para la Lambda."
  type        = map(string)
  default     = {}
}

############################
# Variables del API Gateway
############################

variable "apigateway_http_name" {
  description = "Nombre del API Gateway HTTP."
  type        = string
}

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

variable "default_route_key" {
  description = "Clave de la ruta predeterminada del API Gateway."
  type        = string
  default     = "ANY /"
}

############################
# Variables del WAF
############################

variable "waf_name" {
  description = "Nombre del Web ACL de AWS WAF."
  type        = string
}

variable "waf_description" {
  description = "Descripción del Web ACL."
  type        = string
  default     = "WAF para el API Gateway"
}

variable "rate_limit" {
  description = "Límite de solicitudes por minuto."
  type        = number
  default     = 2000
}

variable "waf_rules" {
  description = <<EOT
Lista de reglas para el WAF.
Cada regla debe ser un objeto con:
- name: Nombre de la regla.
- priority: Prioridad de la regla (entero).
- ip_set_arn: ARN del conjunto de IPs para bloquear.
- metric_name: Nombre de la métrica asociada a la regla.
EOT
  type = list(object({
    name        = string
    priority    = number
    ip_set_arn  = string
    metric_name = string
  }))
  default = []
}
