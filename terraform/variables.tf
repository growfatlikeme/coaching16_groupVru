
variable "dynamodb_table" {
  type        = string
  description = "Name of the DynamoDB table for storing URLs"
  default     = "url-shortener-table"
}