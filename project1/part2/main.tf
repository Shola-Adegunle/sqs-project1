terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5"

    }
  }
}

provider "aws" {
  #shared_credentials_files = ["~/.aws/credentials"]
  profile = "AWS Account2"
  region  = "us-east-1"
}