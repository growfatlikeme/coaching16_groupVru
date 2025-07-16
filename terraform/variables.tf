# Terraform variables for URL Shortener Service
# Contributed by: Vrushali Bavare
# Created on : 14/07/2025
# Last updated: 16/07/2025

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table to be created."
  type        = string
  default     = "url_shortener_table"

}

variable "domain_name" {
  description = "The domain name for the URL shortener service."
  type        = string
  default     = "groupVru.sctp-sandbox.com"

}

variable "hosted_zone_id" {
  description = "The ID of the Route53 hosted zone where the domain is managed."
  type        = string
  default     = "Z00541411T1NGPV97B5C0" # zone ID for sctp-sandbox.com
  
}

variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "ap-southeast-1"
  
}