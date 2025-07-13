resource "aws_dynamodb_table" "url_table" {
  name           = var.dynamodb_table
  hash_key       = "short_id"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "short_id"
    type = "S"
  }
}
