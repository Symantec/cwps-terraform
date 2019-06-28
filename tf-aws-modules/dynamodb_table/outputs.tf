# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "table_id" {
  value = "${element(concat(aws_dynamodb_table.table_wo_range_key.*.id, aws_dynamodb_table.table_w_range_key.*.id), 0)}"
}

output "table_arn" {
  value = "${element(concat(aws_dynamodb_table.table_wo_range_key.*.arn, aws_dynamodb_table.table_w_range_key.*.arn), 0)}"
}
