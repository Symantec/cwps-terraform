# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_autoscaling_group" "asg" {
  desired_capacity          = "${var.desired_capacity}"
  default_cooldown          = "${var.default_cooldown}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  launch_configuration      = "${var.launch_configuration_id}"
  load_balancers            = "${var.load_balancers}"
  target_group_arns         = ["${var.target_group_arns}"]
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  name                      = "${var.name}"
  vpc_zone_identifier       = ["${var.vpc_zone_identifier}"]
  enabled_metrics           = ["${var.enabled_metrics}"]

  tags = ["${concat(
    list(
      map("key", "Name", "value", "${var.name}", "propagate_at_launch", "true")
    ),
    var.asg_tags
  )}"]

  lifecycle {
    create_before_destroy = true
  }
}
