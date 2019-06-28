# -----------------------------------------------------------------------------
# Symantec CWP Settings Table
# -----------------------------------------------------------------------------

module "settings_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.settings_dynamodb_table_name}"
  hash_key       = "componentType"
  range_key      = "settingType"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "componentType"
      type = "S"
    },
    {
      name = "settingType"
      type = "S"
    },
  ]
}
