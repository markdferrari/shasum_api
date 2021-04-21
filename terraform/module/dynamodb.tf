resource "aws_dynamodb_table" "dynamodb" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "String"
  range_key      = "Shasum"

  attribute {
    name = "String"
    type = "S"
  }

  attribute {
    name = "Shasum"
    type = "S"
  }
}