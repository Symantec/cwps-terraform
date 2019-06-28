# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_autoscaling_lifecycle_hook" "lifecycle_hook" {
  name                    = "${var.name}"
  autoscaling_group_name  = "${var.autoscaling_group_name}"
  lifecycle_transition    = "${var.lifecycle_transition}"
  notification_target_arn = "${var.notification_target_arn}"
  role_arn                = "${var.role_arn}"
  default_result          = "${var.default_result}"
  heartbeat_timeout       = "${var.heartbeat_timeout}"
  notification_metadata   = "${var.notification_metadata}"
}
