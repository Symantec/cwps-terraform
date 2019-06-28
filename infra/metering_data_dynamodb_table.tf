# -----------------------------------------------------------------------------
# Symantec CWP Job Table
# -----------------------------------------------------------------------------

module "metering_data_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.metering_data_dynamodb_table_name}"
  hash_key       = "dateString"
  range_key      = "slot"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "dateString"
      type = "S"
    },
    {
      name = "slot"
      type = "N"
    },
  ]
}
