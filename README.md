[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-stage-email)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.15.0-blue.svg)

## Description

Configure SES for a provided stage

- Email Identity
- Domain Identity
- DKIM
- MAIL FROM
- Events to SNS
- Complaint forwarding to the Root Email
- Route53 Records
- no-reply@ bounce message

## Usage

```hcl
resource "aws_ses_receipt_rule_set" "primary" {
  rule_set_name = "primary-rules"
}

resource "aws_ses_active_receipt_rule_set" "primary" {
  rule_set_name = aws_ses_receipt_rule_set.primary.rule_set_name
}

module "stage" {
  source = "scaffoldly/aws/stage-email"

  for_each = var.stage_domains

  stage         = each.key
  root_email    = var.root_email
  mail_domain   = each.value.platform_domains.mail_domain
  dns_provider  = lookup(each.value, "dns_provider" "unknown-dns-provider")
  dns_domain_id = lookup(each.value, "dns_domain_id" "unknown-dns-domain-id")
  rule_set_name = aws_ses_receipt_rule_set.primary.rule_set_name

  providers = {
    aws.dns = aws.dns
  }
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

## Providers

## Modules

## Resources

## Inputs

## Outputs

<!-- END_TF_DOCS -->
