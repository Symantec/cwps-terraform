# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "launch_configuration_id" {
  value = "${aws_launch_configuration.launch_configuration.id}"
}

output "launch_configuration_name" {
  value = "${aws_launch_configuration.launch_configuration.name}"
}
