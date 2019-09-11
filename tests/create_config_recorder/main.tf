provider aws {
  region = "us-east-1"
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

module "create_config_recorder" {
  source = "../../"
  providers = {
    aws = aws
  }

  create_config_rules  = true
  cloudtrail_bucket    = data.terraform_remote_state.prereq.outputs.cloudtrail_bucket
  config_bucket        = data.terraform_remote_state.prereq.outputs.config_bucket
  config_sns_topic_arn = data.terraform_remote_state.prereq.outputs.sns_topic
  config_recorder      = data.terraform_remote_state.prereq.outputs.config_recorder
}
