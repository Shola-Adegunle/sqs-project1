terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5"

    }
  }
}

provider "aws" {
  profile = "profile2"
  region  = "us-east-1"
}