# terraform-aws-tardigrade-config-rules

Terraform module to setup config rules

## AWS Labs Config Rules
* The community config rules provided by AWS are included in this repository. If the rules are out of date you can regenerate them with the following commands
```Makefile
make clean && make vendor
```


<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudtrail\_bucket | Name of S3 bucket to validate that CloudTrail logs are being delivered | `string` | `null` | no |
| config\_bucket | Name of S3 bucket to validate that Config is configured to send inventory to | `string` | `null` | no |
| config\_recorder | The name of the AWS Config recorder | `string` | `null` | no |
| config\_sns\_topic\_arn | ARN of SNS topic to validate that Config changes are being streamed to | `string` | `null` | no |
| create\_config\_rules | Controls whether to create the AWS Config Rules | `bool` | `true` | no |
| exclude\_rules | List of config rule resource names to exclude from creation | `list(string)` | `[]` | no |
| tags | Map of tags to apply to the resources | `map(string)` | `{}` | no |

## Outputs

No output.

<!-- END TFDOCS -->
