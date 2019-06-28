# -----------------------------------------------------------------------------
# Data Sources
# -----------------------------------------------------------------------------

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_kms_key" "sqs_key" {
  key_id = "alias/${local.symantec_namespace}-SymantecCWP-SQS"
}

data "aws_subnet" "management_processing_a" {
  id = "${var.subnet_id}"
}

data "aws_iam_role" "alarm_notification" {
  name = "${local.alarm_notification_iam_policy_name}-role"
}

data "aws_iam_role" "controller" {
  name = "${local.controller_iam_policy_name}"
}

data "aws_iam_role" "pu" {
  name = "${local.pu_iam_policy_name}"
}

data "aws_dynamodb_table" "asset" {
  name = "${local.symantec_namespace}.${local.asset_dynamodb_table_name}"
}

data "aws_dynamodb_table" "discovered_assets" {
  name = "${local.symantec_namespace}.${local.discovered_assets_dynamodb_table_name}"
}

data "aws_dynamodb_table" "command" {
  name = "${local.symantec_namespace}.${local.command_dynamodb_table_name}"
}

data "aws_dynamodb_table" "controller_schedule" {
  name = "${local.symantec_namespace}.${local.controller_schedule_dynamodb_table_name}"
}

data "aws_dynamodb_table" "job" {
  name = "${local.symantec_namespace}.${local.job_dynamodb_table_name}"
}

data "aws_dynamodb_table" "metering_data" {
  name = "${local.symantec_namespace}.${local.metering_data_dynamodb_table_name}"
}

data "aws_dynamodb_table" "settings" {
  name = "${local.symantec_namespace}.${local.settings_dynamodb_table_name}"
}

data "aws_dynamodb_table" "remediation_details" {
  name = "${local.symantec_namespace}.${local.remediation_details_dynamodb_table_name}"
}

data "aws_dynamodb_table" "remediation_exception" {
  name = "${local.symantec_namespace}.${local.remediation_exception_dynamodb_table_name}"
}

data "aws_dynamodb_table" "sync_object_stats" {
  name = "${local.symantec_namespace}.${local.sync_object_stats_dynamodb_table_name}"
}

data "aws_dynamodb_table" "user_schedule" {
  name = "${local.symantec_namespace}.${local.user_schedule_dynamodb_table_name}"
}

data "aws_dynamodb_table" "role_arns" {
  name = "${local.symantec_namespace}.${local.role_arns_dynamodb_table_name}"
}

data "aws_dynamodb_table" "properties" {
  name = "${local.symantec_namespace}.${local.properties_dynamodb_table_name}"
}

data "aws_sqs_queue" "access" {
  name = "${local.symantec_namespace}_${local.sqs_access_queue_name}"
}

data "aws_sns_topic" "alert" {
  name = "${local.alert_sns_topic_name}"
}
