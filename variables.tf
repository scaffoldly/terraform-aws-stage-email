variable "stage" {
  type        = string
  description = "The stage (e.g. live, nonlive)"
}

variable "root_email" {
  type        = string
  description = "The AWS account's email address"
}

variable "mail_domain" {
  type        = string
  description = "The domain that's been configured to send email"
}

variable "dns_provider" {
  type        = string
  description = "The DNS provider (Route53 currently only supported)"
}

variable "dns_domain_id" {
  type        = string
  description = "The Route53 domain ID"
}

variable "rule_set_name" {
  type        = string
  description = "The active rule set name"
}
