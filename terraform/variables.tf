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