terraform {
  required_version = "~> 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.52.0"
    }
  }
  backend "s3" {
    bucket         = "tf-farm-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-farm-state-lock-table"
  }
}

provider "aws" {
  region = "us-east-1"
}

