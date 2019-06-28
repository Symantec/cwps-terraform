# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "dlp_instance_id" {
  value = ["${aws_instance.dlp_instance.*.id}"]
}

output "dlp_public_ip" {
  value = ["${aws_instance.dlp_instance.*.public_ip}"]
}

output "dlp_private_ip" {
  value = ["${aws_instance.dlp_instance.*.private_ip}"]
}