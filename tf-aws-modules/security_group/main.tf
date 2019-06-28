# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_security_group" "security_group" {
  count       = "${var.count != "" ? 1 : 0}"
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(map("Name", "${var.name}"), var.tags)}"
}
