# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_instance" "dlp_instance" {
  count                       = "${var.count != "" ? var.count : 0}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  user_data                   = "${var.user_data}"
  security_groups             = ["${var.security_groups}"]
  subnet_id                   = "${var.subnet_id}"
  ebs_block_device            = ["${var.ebs_block_device}"]
  tags                        = "${merge(map("Name", "${var.name}-${count.index + 1}"), var.tags)}"
}
