# -----------------------------------------------------------------------------
# Symantec CWP Asset Table
# -----------------------------------------------------------------------------

module "asset_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.asset_dynamodb_table_name}"
  hash_key       = "assetName"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "assetName"
      type = "S"
    },
  ]
}
