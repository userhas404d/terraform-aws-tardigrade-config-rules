provider aws {
  region = "us-east-1"
}


module "no_create" {
  source = "../../"
  providers = {
    aws = aws
  }

  create_config_rules = false
}
