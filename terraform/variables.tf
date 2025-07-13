variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table to be created."
  type        = string
  default     = "url_shortener_table"

}