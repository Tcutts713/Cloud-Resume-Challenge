resource "aws_dynamodb_table" "visitorTable" {
  name           = "Visits"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "Count"

  attribute {
    name = "Count"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "Count" {
  table_name = aws_dynamodb_table.visitorTable.name
  hash_key   = aws_dynamodb_table.visitorTable.hash_key

  item = <<ITEM
{
  "Count" : {"S": "0"},
  "counter" : {"N": "0"}
}
ITEM
}