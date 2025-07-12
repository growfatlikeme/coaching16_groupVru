terraform {
  backend "s3" {
    bucket         = "sctp-ce10-tfstate"
    key            = "coaching16_groupvru"
    region         = "ap-southeast-1"
   
  }
}