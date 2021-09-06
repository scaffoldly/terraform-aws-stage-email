output "domain" {
  value       = local.mail_domain
  description = "The full domain for this stage"
}

output "stage" {
  value       = var.stage
  description = "Re-output of var.stage"
}

output "noreply_address" {
  value = local.noreply_address
}

output "noreply_rule_name" {
  value       = aws_ses_receipt_rule.bounce_noreply.id
  description = "The receipt rule ID for the noreply address"
}
