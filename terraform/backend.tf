  terraform {
  backend "s3" {
    bucket         = "sctp-ce10-tfstate"
    key            = "coachoing16_groupvru/terraform.tfstate"
    region         = "ap-southeast-1"
    
  }
  }