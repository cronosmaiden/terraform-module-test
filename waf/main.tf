############################
# AWS WAF - Obtener información de la cuenta actual
############################

data "aws_caller_identity" "current" {}

############################
# AWS WAF - Web ACL
############################

# Crear la Web ACL (Access Control List)
resource "aws_wafv2_web_acl" "this" {
  name        = var.waf_name
  description = var.waf_description
  scope       = var.waf_scope # REGIONAL para API Gateway
  default_action {
    allow {}
  }

  visibility_config {
    sampled_requests_enabled = true
    cloudwatch_metrics_enabled = true
    metric_name = var.waf_metric_name
  }

  # Reglas de la ACL
  dynamic "rule" {
    for_each = var.waf_rules
    content {
      name     = rule.value.name
      priority = rule.value.priority
      action {
        block {} # Bloquear por defecto
      }
      statement {
        ip_set_reference_statement {
          arn = rule.value.ip_set_arn
        }
      }
      visibility_config {
        sampled_requests_enabled  = true
        cloudwatch_metrics_enabled = true
        metric_name               = rule.value.metric_name
      }
    }
  }

  # Regla de Rate Limiting
  rule {
    name     = "rate-limit-rule"
    priority = 0 # Prioridad más alta
    action {
      block {} # Bloquear solicitudes excesivas
    }
    statement {
      rate_based_statement {
        limit            = var.rate_limit
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      sampled_requests_enabled  = true
      cloudwatch_metrics_enabled = true
      metric_name               = "rate-limit-metric"
    }
  }
}

############################
# AWS WAF - Asociar al API Gateway
############################

resource "null_resource" "wait_for_stage" {
  # Depender explícitamente del API Gateway para garantizar orden de ejecución
  depends_on = [
    var.api_gateway_dependency
  ]

  provisioner "local-exec" {
    # Verificar que el API Gateway esté listo
    command = <<EOT
    for i in {1..10}; do
      echo "Verificando si el API Gateway está listo... (intento $i)"
      aws apigatewayv2 get-api --api-id "${var.api_gateway_id}" --region "${var.region}" > /dev/null 2>&1
      if [ $? -eq 0 ]; then
        echo "API Gateway listo."
        exit 0
      fi
      sleep 10
    done
    echo "Error: El API Gateway no está listo después de varios intentos." >&2
    exit 1
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "aws_wafv2_web_acl_association" "this" {
  depends_on = [
    aws_wafv2_web_acl.this,
    null_resource.wait_for_stage
  ]

  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}