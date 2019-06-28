# -----------------------------------------------------------------------------
# Symantec CWP Role_Arns Table
# -----------------------------------------------------------------------------

module "role_arns_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.role_arns_dynamodb_table_name}"
  hash_key       = "arn"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "arn"
      type = "S"
    },
  ]
}