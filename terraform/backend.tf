# Terraform backend configuration
# Contributed by: Vrushali Bavare
# Created on : 14/07/2025
# Last updated: 16/07/2025

terraform {
  backend "s3" {
    bucket = "sctp-ce10-tfstate"
    key    = "coachoing16_groupvru/terraform.tfstate"
    region = "ap-southeast-1"

  }
}