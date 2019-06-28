# -----------------------------------------------------------------------------
# Symantec CWP Controller Schedule Table
# -----------------------------------------------------------------------------

module "controller_schedule_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.controller_schedule_dynamodb_table_name}"
  hash_key       = "scheduleId"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "scheduleId"
      type = "S"
    },
  ]
}
