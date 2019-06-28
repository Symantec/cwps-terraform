# -----------------------------------------------------------------------------
# Symantec CWP Sync Object Stats Table
# -----------------------------------------------------------------------------

module "sync_object_stats_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.sync_object_stats_dynamodb_table_name}"
  hash_key       = "syncType"
  range_key      = "componentName"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "syncType"
      type = "S"
    },
    {
      name = "componentName"
      type = "S"
    },
  ]
}
