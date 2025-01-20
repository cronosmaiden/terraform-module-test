############################
# Variables del WAF
############################

variable "waf_name" {
  description = "Nombre del Web ACL de AWS WAF."
  type        = string
}

variable "waf_description" {
  description = "Descripción del Web ACL de AWS WAF."
  type        = string
  default     = "WAF ACL for API Gateway"
}

variable "waf_scope" {
  description = "Ámbito del WAF (REGIONAL o CLOUDFRONT)."
  type        = string
  default     = "REGIONAL"
}

variable "waf_metric_name" {
  description = "Nombre de la métrica de CloudWatch asociada al WAF."
  type        = string
  default     = "waf-acl-metric"
}

variable "waf_rules" {
  description = <<EOT
Lista de reglas para el WAF.
Cada regla debe ser un objeto con:
- name: Nombre de la regla.
- priority: Prioridad de la regla (entero).
- ip_set_arn: ARN del conjunto de IPs para bloquear.
- metric_name: Nombre de la métrica de CloudWatch asociada a la regla.
EOT
  type = list(object({
    name        = string
    priority    = number
    ip_set_arn  = string
    metric_name = string
  }))
  default = []
}

variable "rate_limit" {
  description = "Límite de solicitudes por minuto para la regla de rate limiting."
  type        = number
  default     = 2000
}

variable "region" {
  description = "Región donde se despliegan los recursos."
  type        = string
}

variable "api_gateway_id" {
  description = "ID del API Gateway para asociarlo con el WAF."
  type        = string
}

############################
# Asociar al API Gateway
############################

# Variable para recibir el ARN del API Gateway
variable "resource_arn" {
  description = "ARN del API Gateway al que se asociará el WAF"
  type        = string
}

# Variable para manejar dependencias explícitas desde el módulo raíz
variable "api_gateway_dependency" {
  description = "Dependencia explícita para esperar la creación del API Gateway y su stage"
  default     = [] # Valor por defecto vacío
  type        = list(any)
}