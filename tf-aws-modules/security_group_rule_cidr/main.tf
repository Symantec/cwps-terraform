# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_security_group_rule" "rule" {
  count             = "${var.count != "" ? 1 : 0}"
  type              = "${var.rule_type}"
  protocol          = "${var.protocol}"
  from_port         = "${var.from_port}"
  to_port           = "${var.to_port}"
  cidr_blocks       = ["${var.cidr_blocks}"]
  security_group_id = "${var.security_group_id}"
}
