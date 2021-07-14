output "no_reply_rule_name" {
  value = aws_ses_receipt_rule.bounce_noreply.id
}
