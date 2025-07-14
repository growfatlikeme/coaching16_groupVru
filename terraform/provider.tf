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