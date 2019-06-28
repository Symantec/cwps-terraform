# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "role_unique_id" {
  value = "${aws_iam_role.role.unique_id}"
}

output "role_name" {
  value = "${aws_iam_role.role.name}"
}
