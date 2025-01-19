############################
# Outputs del WAF
############################

output "waf_arn" {
  description = "ARN del Web ACL de AWS WAF."
  value       = aws_wafv2_web_acl.this.arn
}

output "waf_id" {
  description = "ID del Web ACL de AWS WAF."
  value       = aws_wafv2_web_acl.this.id
}

output "associated_resource_arn" {
  description = "ARN del recurso asociado al WAF (por ejemplo, API Gateway)."
  value       = aws_wafv2_web_acl_association.this.resource_arn
}
