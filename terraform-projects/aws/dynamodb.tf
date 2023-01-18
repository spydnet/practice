resource "aws_dynamodb_table" "cars" {
  name = "cars"
  hash_key = "VIN"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "VIN"
    type = "S"

  }
}

resource "aws_dynamodb_table_item" "car-items" {
  table_name = aws_dynamodb_table.cars.name
  hash_key = aws_dynamodb_table.cars.hash_key
  item = <<EOF
{
    "Manafacturer": {"S":"Toyota"},
    "Make": {"S":"Corolla"},
    "Year": {"N":"2020"},
    "VIN": {"S":"AKJDBFHKJABGVAB2345N"}
}
EOF
}

resource "aws_dynamodb_table_item" "car-item-skoda" {
  table_name = aws_dynamodb_table.cars.name
  hash_key = aws_dynamodb_table.cars.hash_key
  item = <<EOF
{
    "Manafacturer": {"S":"Skoda"},
    "Make": {"S":"Octavia"},
    "Year": {"N":"2018"},
    "VIN": {"S":"SKODABFHKJABGVAB2345N"}
}
EOF
}