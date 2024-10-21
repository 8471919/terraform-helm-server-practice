provider "aws" {
  profile = "cloud-club-aws"
  region = "${var.region}"
}

terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}