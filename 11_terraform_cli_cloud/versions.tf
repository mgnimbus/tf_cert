terraform {
  required_version = "~> 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.52.0"
    }
  }
  cloud {
    organization = "hcta_demo"

    workspaces {
      name = "cli-driven-demo"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
