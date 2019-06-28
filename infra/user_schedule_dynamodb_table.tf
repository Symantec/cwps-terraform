# -----------------------------------------------------------------------------
# Symantec CWP User Schedule Table
# -----------------------------------------------------------------------------

module "user_schedule_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.user_schedule_dynamodb_table_name}"
  hash_key       = "scheduleId"
  range_key      = "createdTime"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "scheduleId"
      type = "S"
    },
    {
      name = "scheduleName"
      type = "S"
    },
    {
      name = "createdTime"
      type = "N"
    },
  ]

  global_secondary_index = [
    {
      name               = "userScheduleGSI"
      hash_key           = "scheduleName"
      range_key          = "createdTime"
      write_capacity     = "5"
      read_capacity      = "5"
      projection_type    = "INCLUDE"
      non_key_attributes = ["isDeleted", "scheduleId"]
    },
  ]
}
