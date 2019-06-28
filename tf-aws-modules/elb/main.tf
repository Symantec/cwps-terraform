# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_elb" "elastic_loadbalancer" {
  count           = "${var.count != "" ? 1 : 0}"
  name            = "${var.name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.internal}"
  security_groups = ["${var.security_groups}"]

  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  listener     = ["${var.listener}"]
  access_logs  = ["${var.access_logs}"]
  health_check = ["${var.health_check}"]

  tags         = "${var.tags}"
  
  instances    = ["${var.instances}"]
}