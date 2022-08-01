resource "aws_dynamodb_table" "main" {
  name           = "Participant"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = var.hash_key
  range_key      = var.range_key

  dynamic "attribute" {
    for_each = var.table_attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
}
