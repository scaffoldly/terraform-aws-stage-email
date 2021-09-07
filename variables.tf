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

variable "subdomain_suffix" {
  type        = string
  description = "The (optional) suffix to append to the subdomain"
}

variable "zone_id" {
  type        = string
  description = "The zone ID for the domain"
}

variable "rule_set_name" {
  type        = string
  description = "The active rule set name"
}
