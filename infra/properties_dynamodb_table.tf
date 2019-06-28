# -----------------------------------------------------------------------------
# Symantec CWP Properties Table
# -----------------------------------------------------------------------------

module "properties_details_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.properties_dynamodb_table_name}"
  hash_key       = "propertyName"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "propertyName"
      type = "S"
    },
  ]
}
