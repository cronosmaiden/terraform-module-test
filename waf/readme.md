# Módulo WAF - Terraform

Este módulo crea un **AWS WAF (Web Application Firewall)** con reglas de bloqueo de IP y rate limiting, y lo asocia a un recurso como un **API Gateway**.

## Requisitos

- Terraform v1.5.2
- Provider AWS v5.45.0

## Variables

### Configuración del WAF
- `waf_name`: Nombre del Web ACL de AWS WAF (string, requerido).
- `waf_description`: Descripción del Web ACL (string, opcional, por defecto: "WAF ACL for API Gateway").
- `waf_scope`: Ámbito del WAF, puede ser `REGIONAL` (API Gateway) o `CLOUDFRONT` (string, opcional, por defecto: "REGIONAL").
- `waf_metric_name`: Nombre de la métrica de CloudWatch asociada al WAF (string, opcional, por defecto: "waf-acl-metric").

### Reglas del WAF
- `waf_rules`: Lista de reglas para el WAF. Cada regla es un objeto que incluye:
  - `name`: Nombre de la regla (string).
  - `priority`: Prioridad de la regla (entero).
  - `ip_set_arn`: ARN del conjunto de IPs para bloquear (string).
  - `metric_name`: Nombre de la métrica asociada a la regla (string).
- `rate_limit`: Límite de solicitudes por minuto (número, opcional, por defecto: 2000).

### Asociación al API Gateway
- `resource_arn`: ARN del recurso al que se asociará el WAF, como un API Gateway (string, requerido).

## Outputs

- `waf_arn`: ARN del Web ACL de AWS WAF.
- `waf_id`: ID del Web ACL de AWS WAF.
- `associated_resource_arn`: ARN del recurso asociado al WAF.

## Ejemplo de Uso

```hcl
module "waf" {
  source = "./waf"

  waf_name        = "my-waf-acl"
  waf_description = "WAF for my API Gateway"
  rate_limit      = 1000

  waf_rules = [
    {
      name        = "block-specific-ips"
      priority    = 1
      ip_set_arn  = "arn:aws:wafv2:us-east-1:123456789012:regional/ipset/my-ip-set/12345678-1234-1234-1234-123456789012"
      metric_name = "blocked-ips-metric"
    }
  ]

  resource_arn = "arn:aws:apigateway:us-east-1::/restapis/<api-id>/stages/<stage-name>"
}
