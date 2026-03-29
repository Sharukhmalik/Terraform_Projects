terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 2.55"
        }
    }
}


provider "aws" {
    profile = "default"
    region  = var.region
}