resource "aws_dynamodb_table" "url_shortener_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "short_id"
    type = "S"
  }

  hash_key = "short_id"

  tags = {
    Name        = var.dynamodb_table_name
    Environment = "Development"
  }
}