# Terraform configuration for AWS provider
# Contributed by: Vrushali Bavare and Estee
# Created on : 14/07/2025
# Last updated: 16/07/2025
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.0"
}
provider "aws" {
  region = "ap-southeast-1"


  default_tags {
    tags = {
      Environment = "Development" # Dynamically fetch the environment from variable
      Name        = "groupVru"    # Dynamically fetch the name from variable
      Owner       = "NTU-SCTP-COHORT10"
      Project     = "Coaching16"
    }
  }
}