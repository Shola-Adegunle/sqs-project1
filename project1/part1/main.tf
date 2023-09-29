terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5"

    }
  }

    # backend "s3" {
    #   bucket         = "sadey2k2-tf-state-location"
    #   key            = "dev.terraform.tfstate"
    #   region         = "us-east-1"
    #   dynamodb_table = "dev-terraform-state-locking"
    # }
}

provider "aws" {
  profile = "profile2"
  region  = "us-east-1"
}