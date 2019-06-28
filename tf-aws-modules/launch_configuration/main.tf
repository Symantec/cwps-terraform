# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_launch_configuration" "launch_configuration" {
  associate_public_ip_address = "${var.associate_public_ip_address}"
  name_prefix                 = "${var.name_prefix}-"
  iam_instance_profile        = "${var.iam_instance_profile}"
  image_id                    = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  user_data                   = "${var.user_data}"
  security_groups             = ["${var.security_groups}"]
  root_block_device           = ["${var.root_block_device}"]
  ebs_block_device            = ["${var.ebs_block_device}"]

  lifecycle {
    create_before_destroy = true
  }
}
