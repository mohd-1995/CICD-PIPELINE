terraform {
  backend "s3" {
    bucket = "git-moe-aws"
    key = "terraform/state/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt = false
  }
}


