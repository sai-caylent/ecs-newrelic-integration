terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37"
    }
  }
  required_version = ">= 1.3.3"
}
provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Environment = "Test"
      Owner       = "sai"
      Project     = "F45"
    }
  }
}
