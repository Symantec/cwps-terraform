# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "role_name" {
  value = "${module.iam_role.role_name}"
}

output "role_arn" {
  value = "${module.iam_role.role_arn}"
}

output "role_unique_id" {
  value = "${module.iam_role.role_unique_id}"
}

output "policy_id" {
  value = "${module.iam_policy.policy_id}"
}

output "policy_arn" {
  value = "${module.iam_policy.policy_arn}"
}

output "policy_name" {
  value = "${module.iam_policy.policy_name}"
}
