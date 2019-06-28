# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Modules
# -----------------------------------------------------------------------------

module "iam_role" {
  role_name          = "${var.name}-role"
  assume_role_policy = "${var.assume_role_policy}"
  source             = "../iam_role"
}

module "iam_policy" {
  policy_name = "${var.name}-policy"
  policy      = "${var.policy}"
  source      = "../iam_policy"
}

module "attach_policy_to_role" {
  role       = "${module.iam_role.role_name}"
  policy_arn = "${module.iam_policy.policy_arn}"
  source     = "../iam_role_policy_attachment"
}
