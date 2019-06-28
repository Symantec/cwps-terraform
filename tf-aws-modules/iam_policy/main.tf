# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_iam_policy" "policy" {
  name        = "${var.policy_name}"
  description = "${var.policy_description}"
  path        = "${var.policy_path}"
  policy      = "${var.policy}"
}
