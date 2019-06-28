# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_kms_key" "key" {
  description             = "${var.description}"
  key_usage               = "${var.key_usage}"
  policy                  = "${var.policy}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  enable_key_rotation     = "${var.enable_key_rotation}"

  tags = "${merge(map("Name", "${var.description}"), var.tags)}"
}

resource "aws_kms_alias" "alias" {
  count = "${var.kms_key_alias == "" ? 0 : 1}"

  name          = "${var.kms_key_alias}"
  target_key_id = "${aws_kms_key.key.key_id}"
}
