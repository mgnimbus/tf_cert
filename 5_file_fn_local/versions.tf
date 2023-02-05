terraform {
  required_version = "~> 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.52.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# provider "aws" {
#   region = "us-west-1"
#   alias  = "westy"
# }
