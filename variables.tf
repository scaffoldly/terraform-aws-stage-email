variable "stage" {
  type        = string
  description = "The stage (e.g. live, nonlive)"
}

variable "root_email" {
  type        = string
  description = "The AWS account's email address"
}

variable "subdomain" {
  type        = string
  description = "The subdomain for sending/receiving emails"
}

variable "domain" {
  type        = string
  description = "The domain for sending/receiving emails"
}

variable "rule_set_name" {
  type        = string
  description = "The active rule set name"
}
