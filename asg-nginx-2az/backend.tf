terraform {
  required_version = "1.16.4"
  backend "s3" {
    bucket       = "mon-super-backend-tfstate-2026"
    region       = "eu-west-2"
    key          = "3-tier/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}