variable "create_config_rules" {
  description = "Controls whether to create the AWS Config Rules"
  default     = true
}

variable "cloudtrail_bucket" {
  description = "Name of S3 bucket to validate that CloudTrail logs are being delivered"
  type        = string
  default     = null
}

variable "config_recorder" {
  description = "The name of the AWS Config recorder"
  type        = string
  default     = null
}

variable "exclude_rules" {
  description = "List of config rule resource names to exclude from creation"
  type        = list(string)
  default     = []
}

variable "config_bucket" {
  description = "Name of S3 bucket to validate that Config is configured to send inventory to"
  type        = string
  default     = null
}

variable "config_sns_topic_arn" {
  description = "ARN of SNS topic to validate that Config changes are being streamed to"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to apply to the resources"
  type        = map(string)
  default     = {}
}
