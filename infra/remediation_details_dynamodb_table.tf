# -----------------------------------------------------------------------------
# Symantec CWP Remediation Details Table
# -----------------------------------------------------------------------------

module "remediation_details_dynamo_table" {
  name           = "${local.symantec_namespace}.${local.remediation_details_dynamodb_table_name}"
  hash_key       = "bucketName"
  write_capacity = "5"
  read_capacity  = "5"
  source         = "../tf-aws-modules/dynamodb_table"

  attribute = [
    {
      name = "bucketName"
      type = "S"
    },
  ]
}
