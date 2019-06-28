# -----------------------------------------------------------------------------
# Local Variables
# -----------------------------------------------------------------------------

locals {
  alarm_notification_iam_policy_name        = "${var.dcio}-${var.application_name}-alert-${var.environment}"
  controller_iam_policy_name                = "${var.dcio}-${var.application_name}-controller-${var.environment}"
  controller_iam_instance_profile           = "${var.dcio}-${var.application_name}-controller-${var.environment}"
  pu_iam_policy_name                        = "${var.dcio}-${var.application_name}-pu-${var.environment}"
  pu_iam_instance_profile                   = "${var.dcio}-${var.application_name}-pu-${var.environment}"
  alert_sns_topic_name                      = "${var.dcio}-${var.application_name}-alerts-${var.environment}"
  pu_security_group_name                    = "${var.dcio}-${var.application_name}-pu-sg-${var.environment}"
  # -----------------------------------------------------------------------------
  # ${symantec_namespace}-PUGroupPolicy is mandatory word for PU autoscaling group name
  # -----------------------------------------------------------------------------
  pu_autoscaling_group_name                 = "${var.dcio}-${var.application_name}-${var.environment}-PUGroupPolicy"
  pu_autoscaling_lifecycle_name             = "${var.dcio}-${var.application_name}-controller-lifecycle-${var.environment}"
  controller_security_group_name            = "${var.dcio}-${var.application_name}-controller-sg-${var.environment}"
  # -----------------------------------------------------------------------------
  # ${symantec_namespace}-CUGroupPolicy is mandatory word for CU autoscaling group name
  # -----------------------------------------------------------------------------
  controller_autoscaling_group_name         = "${var.dcio}-${var.application_name}-${var.environment}-CUGroupPolicy"
  controller_autoscaling_lifecycle_name     = "${var.dcio}-${var.application_name}-controller-lifecycle-${var.environment}"
  dlp_security_group_name                   = "${var.dcio}-${var.application_name}-dlp-sg-${var.environment}"
  elb_security_group_name                   = "${var.dcio}-${var.application_name}-elb-sg-${var.environment}"
  elb_name                                  = "${var.dcio}-${var.application_name}-elb-${var.environment}"
  dlp_name                                  = "${var.dcio}-${var.application_name}-dlp-${var.environment}"
  symantec_namespace                        = "${var.dcio}-${var.application_name}-${var.environment}"
  sqs_access_queue_name                     = "OnAccessQueue"
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
  discovery_mode                            = "Manual"
  bucket_configuration                      = "Configure automatically (Link through SNS & SQS)"
  

  pu_ami_id         = "${lookup(var.pu_amis, var.aws_region)}"
  controller_ami_id = "${lookup(var.cu_amis, var.aws_region)}"
  dlp_ami_id        = "${lookup(var.dlp_amis, var.aws_region)}"

  dlp_user_data = <<EOF
{
"password": "${var.cli_password}",
"enable_password": "${var.cli_enable_password}"
}
  EOF
  
  auth_proxy = <<AUTH
${var.proxy_user}:${var.proxy_password}@AUTH

  proxy_address = "${var.proxy_host}:${var.proxy_port}"

  proxy_setting = <<PROXY
export http_proxy=http://${var.proxy_user != "" ? local.auth_proxy : ""}${local.proxy_address}
export https_proxy=http://${var.proxy_user != "" ? local.auth_proxy : ""}${local.proxy_address}
export NO_PROXY=169.254.169.254
  PROXY
  
  dlp_opted = "${var.cli_password != "" && var.cli_enable_password != "" && var.client_certificate_path != "" && var.certificate_pass_phrase != "" && var.application_configuration_id != "" ? 1 : 0}"
  
  tags = {
    "BrIT Number"        = "${var.barometer_it_number}"
    "ARP Classification" = "${var.arp_classification}"
    "DCIO"               = "${var.dcio}"
    "BISO"               = "${var.biso}"
    "Product Owner"      = "${var.product_owner}"
    "Cost Center"        = "${var.cost_center}"
  }

  asg_tags = [
    {
      key                 = "BrIT Number"
      value               = "${var.barometer_it_number}"
      propagate_at_launch = true
    },
    {
      key                 = "ARP Classification"
      value               = "${var.arp_classification}"
      propagate_at_launch = true
    },
    {
      key                 = "DCIO"
      value               = "${var.dcio}"
      propagate_at_launch = true
    },
    {
      key                 = "BISO"
      value               = "${var.biso}"
      propagate_at_launch = true
    },
    {
      key                 = "Product Owner"
      value               = "${var.product_owner}"
      propagate_at_launch = true
    },
    {
      key                 = "Cost Center"
      value               = "${var.cost_center}"
      propagate_at_launch = true
    },
  ]
}
