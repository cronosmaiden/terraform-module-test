variable "lambda_function_name" {
  description = "Nombre de la función Lambda."
  type        = string
}

variable "lambda_function_role" {
  description = "ARN del rol que la Lambda asumirá."
  type        = string
}

variable "lambda_function_runtime" {
  description = "Runtime de la Lambda (por ejemplo, python3.9)."
  type        = string
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
  default     = 3
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

variable "lambda_function_additional_tags" {
  description = "Mapa de etiquetas adicionales para la Lambda."
  type        = map(string)
  default     = {}
}

variable "lambda_function_security_group" {
  description = "Lista de grupos de seguridad para la Lambda."
  type        = list(string)
  default     = []
}

variable "lambda_function_subnet_ids" {
  description = "Lista de subnets en las que se ejecutará la Lambda."
  type        = list(string)
  default     = []
}

variable "lambda_function_ephemeral_storage" {
  description = "Almacenamiento efímero asignado a la Lambda (en MB)."
  type        = number
  default     = 512
}

variable "lambda_function_tracing_config_mode" {
  description = "Modo de configuración de tracing para X-Ray."
  type        = string
  default     = "PassThrough"
}

variable "api_gateway_source_arn" {
  description = "ARN del API Gateway que invocará la Lambda."
  type        = string
}
