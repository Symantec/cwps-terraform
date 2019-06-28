# -----------------------------------------------------------------------------
# Symantec CWP Discovered Asset Table
# -----------------------------------------------------------------------------

module "discovered_assets_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.discovered_assets_dynamodb_table_name}"
  hash_key       = "name"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "name"
      type = "S"
    },
  ]
}
