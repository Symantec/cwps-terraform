# -----------------------------------------------------------------------------
# Local Variables
# -----------------------------------------------------------------------------

locals {
  alert_sns_topic_name                      = "${var.dcio}-${var.application_name}-alerts-${var.environment}"
  symantec_namespace                        = "${var.dcio}-${var.application_name}-${var.environment}"
  asset_dynamodb_table_name                 = "asset"
  discovered_assets_dynamodb_table_name     = "discovered_assets"
  controller_schedule_dynamodb_table_name   = "controller_schedule"
  job_dynamodb_table_name                   = "job"
  metering_data_dynamodb_table_name         = "MeteringData"
  command_dynamodb_table_name               = "command"
  settings_dynamodb_table_name              = "settings"
  remediation_details_dynamodb_table_name   = "remediation_details"
  remediation_exception_dynamodb_table_name = "remediation_exception"
  sync_object_stats_dynamodb_table_name     = "sync_object_stats"
  user_schedule_dynamodb_table_name         = "user_schedule"
  role_arns_dynamodb_table_name             = "role_arns"
  properties_dynamodb_table_name            = "properties"


  tags = {
    "BrIT Number"        = "${var.barometer_it_number}"
    "ARP Classification" = "${var.arp_classification}"
    "DCIO"               = "${var.dcio}"
    "BISO"               = "${var.biso}"
    "Product Owner"      = "${var.product_owner}"
    "Cost Center"        = "${var.cost_center}"
  }
}
