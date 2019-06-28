# DynamoDB Table

## Usage

```hcl
module "dynamo_table" {
  name = "db_table"
  hash_key = "assetName"
  write_capacity = "5"
  read_capacity = "5"
  source = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//dynamodb_table"

  attributes = [
    {
      name = "assetName",
      type = "S"
    }
  ]
}
```

## Required Variables

* `name`: The name of the DynamoDB Table.
* `hash_key`: The attribute to use as the hash (partition) key.
* `attributes`: List of nested attribute definitions. Only required for hash_key and range_key attributes.
* `write_capacity`: The number of write units for this table
* `read_capacity`: The number of read units for this table

## Optional Variables

* `range_key`: The attribute to use as the range (sort) key.
* `tags`: A map of tags to associate with the table.
* `global_secondary_index`: Describe a GSO for the table; subject to the normal limits on the number of GSIs, projected attributes, etc.
* `local_secondary_index`: Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource.

## Outputs

* `table_id`: The Id of the DynamoDB Table
* `table_arn`: The ARN of the DynamoDB Table

## Terraform Resources

* [aws_dynamodb_table](https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html)
