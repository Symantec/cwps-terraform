# -----------------------------------------------------------------------------
# Symantec CWP Command Table
# -----------------------------------------------------------------------------

module "command_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.command_dynamodb_table_name}"
  hash_key       = "commandId"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "commandId"
      type = "S"
    },
  ]
}
