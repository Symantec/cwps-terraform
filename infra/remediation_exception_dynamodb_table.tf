# -----------------------------------------------------------------------------
# Symantec CWP Remediation Exception Table
# -----------------------------------------------------------------------------

module "remediation_exception_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.remediation_exception_dynamodb_table_name}"
  hash_key       = "bucketName"
  range_key      = "createdTime"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "bucketName"
      type = "S"
    },
    {
      name = "createdTime"
      type = "N"
    },
  ]
}
