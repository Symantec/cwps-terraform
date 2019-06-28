# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "instance_profile_id" {
  value = "${aws_iam_instance_profile.profile.id}"
}

output "instance_profile_arn" {
  value = "${aws_iam_instance_profile.profile.arn}"
}

output "instance_profile_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "instance_profile_unique_id" {
  value = "${aws_iam_instance_profile.profile.unique_id}"
}

output "instance_profile_path" {
  value = "${aws_iam_instance_profile.profile.path}"
}
