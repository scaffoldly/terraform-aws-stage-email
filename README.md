[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-stage-email)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.0.4-blue.svg)

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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.57.0 |
| <a name="provider_aws.dns"></a> [aws.dns](#provider\_aws.dns) | 3.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.dkim_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.mail_domain_mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.mail_from_mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.mail_from_txt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_configuration_set.configuration_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_configuration_set) | resource |
| [aws_ses_domain_dkim.dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_identity_verification.domain_identity_verification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification) | resource |
| [aws_ses_domain_mail_from.mail_from](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_mail_from) | resource |
| [aws_ses_email_identity.identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_email_identity) | resource |
| [aws_ses_event_destination.sns_destination](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_event_destination) | resource |
| [aws_ses_event_destination.sns_destination_bounce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_event_destination) | resource |
| [aws_ses_event_destination.sns_destination_complaint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_event_destination) | resource |
| [aws_ses_identity_notification_topic.bounce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_notification_topic) | resource |
| [aws_ses_identity_notification_topic.complaint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_notification_topic) | resource |
| [aws_ses_identity_notification_topic.delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_notification_topic) | resource |
| [aws_ses_receipt_rule.bounce_noreply](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_receipt_rule) | resource |
| [aws_sns_topic.bounce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.complaint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.root_email_compaints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.event_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The domain for sending/receiving emails | `string` | n/a | yes |
| <a name="input_root_email"></a> [root\_email](#input\_root\_email) | The AWS account's email address | `string` | n/a | yes |
| <a name="input_rule_set_name"></a> [rule\_set\_name](#input\_rule\_set\_name) | The active rule set name | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The stage (e.g. live, nonlive) | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain for sending/receiving emails | `string` | n/a | yes |
| <a name="input_subdomain_suffix"></a> [subdomain\_suffix](#input\_subdomain\_suffix) | The (optional) suffix to append to the subdomain | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The zone ID for var.domain | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain"></a> [domain](#output\_domain) | The full domain for this stage |
| <a name="output_noreply_address"></a> [noreply\_address](#output\_noreply\_address) | n/a |
| <a name="output_noreply_rule_name"></a> [noreply\_rule\_name](#output\_noreply\_rule\_name) | The receipt rule ID for the noreply address |
| <a name="output_stage"></a> [stage](#output\_stage) | Re-output of var.stage |
<!-- END_TF_DOCS -->
