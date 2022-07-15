terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "abcballpark"
    workspaces {
      name = "sandbox"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
