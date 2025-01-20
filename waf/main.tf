# AWS WAF - Obtener información de la cuenta actual
data "aws_caller_identity" "current" {}

############################
# AWS WAF - Web ACL
############################

# Crear la Web ACL (Access Control List)
resource "aws_wafv2_web_acl" "this" {
  name        = var.waf_name
  description = var.waf_description
  scope       = var.waf_scope
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
        block {}
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
    priority = 0
    action {
      block {}
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

resource "aws_wafv2_web_acl_association" "this" {
  depends_on = [aws_wafv2_web_acl.this]

  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}