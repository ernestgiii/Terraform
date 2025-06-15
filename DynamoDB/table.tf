# This file creates our DynamoDB table 


resource "aws_dynamodb_table" "Inventory_DB" {
  name           = "Inventory"   #Name of table
  billing_mode   = "PROVISIONED" #billing mode is optional as it is defaulted to provisioned 
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "GamingInventoryItems" # required. Forces new resource 
  attribute {
    name = "GamingInventoryItems" # required
    type = "S"
  }
  tags = {
    Name = "Game Inventory"
  }
}