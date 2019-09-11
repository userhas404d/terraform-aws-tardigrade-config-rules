provider aws {
  region = "us-east-1"
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "config_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "config" {
  statement {
    actions   = ["s3:PutObject*"]
    resources = ["arn:${data.aws_partition.current.partition}:s3:::${aws_s3_bucket.this.id}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:${data.aws_partition.current.partition}:s3:::${aws_s3_bucket.this.id}"]
  }
}

resource "random_string" "this" {
  length  = 6
  number  = false
  special = false
  upper   = false
}

resource "aws_iam_role" "this" {
  name               = "tardigrade-config-rules-${random_string.this.result}"
  assume_role_policy = data.aws_iam_policy_document.config_assume_role.json
}

resource "aws_iam_role_policy" "this" {
  name   = "tardigrade-config-rules-${random_string.this.result}"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.config.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_config_configuration_recorder" "this" {
  name     = "tardigrade-config-recorder-${random_string.this.result}"
  role_arn = aws_iam_role.this.arn

  recording_group {
    all_supported                 = "true"
    include_global_resource_types = "true"
  }

  depends_on = [
    aws_iam_role_policy.this,
    aws_iam_role_policy_attachment.this,
  ]
}

resource "aws_s3_bucket" "this" {
  bucket        = "tardigrade-config-rules-${random_string.this.result}"
  force_destroy = true
}

resource "aws_sns_topic" "this" {
  name = "tardigrade-config-rules-${random_string.this.result}"
}

output "config_bucket" {
  value = aws_s3_bucket.this.id
}

output "cloudtrail_bucket" {
  value = aws_s3_bucket.this.id
}

output "config_recorder" {
  value = aws_config_configuration_recorder.this.id
}

output "sns_topic" {
  value = aws_sns_topic.this.arn
}
