terraform {
  required_version = "~> 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.52.0"
    }
  }
  cloud {
    hostname     = "app.terraform.io"
    organization = "hcta_demo"

    workspaces {
      name = "state-migration-demo"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


