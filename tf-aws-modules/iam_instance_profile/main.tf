# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_iam_instance_profile" "profile" {
  name = "${var.instance_profile_name}"
  path = "${var.instance_profile_path}"
  role = "${var.iam_role}"
}
