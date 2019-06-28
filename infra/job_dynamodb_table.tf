# -----------------------------------------------------------------------------
# Symantec CWP Job Table
# -----------------------------------------------------------------------------

module "job_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.job_dynamodb_table_name}"
  hash_key       = "jobId"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "jobId"
      type = "S"
    },
  ]
}
