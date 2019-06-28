# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_iam_role" "role" {
  name        = "${var.role_name}"
  description = "${var.role_description}"
  path        = "${var.role_path}"

  assume_role_policy = "${var.assume_role_policy}"
}
