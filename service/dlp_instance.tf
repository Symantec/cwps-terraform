# -----------------------------------------------------------------------------
# DLP Detector Instance
# -----------------------------------------------------------------------------

module "dlp_instance" {
  count                = "${local.dlp_opted ==1 ? var.dlp_instance_count : 0}"
  name                 = "${local.dlp_name}"
  ami_id               = "${local.dlp_ami_id}"
  instance_type        = "${var.dlp_instance_type}"
  subnet_id            = "${data.aws_subnet.management_processing_a.id}"
  source               = "../tf-aws-modules/dlp_instance"
  tags                 = "${local.tags}"
  ebs_block_device = [
    {
      delete_on_termination = "true"
      volume_type           = "gp2"
      volume_size           = "50"
      device_name           = "/dev/sda1"
    }
  ]

  security_groups = [
    "${module.dlp_security_group.security_group_id}",
  ]

  user_data = <<USERDATA
{
"password": "${var.cli_password}",
"enable_password": "${var.cli_enable_password}"
}
  USERDATA
}