# modules/security-group/versions.tf
terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.55"
    }
  }
}