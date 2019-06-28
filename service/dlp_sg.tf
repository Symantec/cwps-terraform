# -----------------------------------------------------------------------------
# Create security groups for DLP instances
# -----------------------------------------------------------------------------

module "dlp_security_group" {
  count       = "${local.dlp_opted ==1 ? 1 : 0}"
  name        = "${local.dlp_security_group_name}"
  description = "Symantec CWP DLP Security Group"
  vpc_id      = "${var.vpc_id}"
  tags        = "${local.tags}"
  source      = "../tf-aws-modules/security_group"
}

module "dlp_sg_ssh_ingress" {
  count             = "${local.dlp_opted ==1 ? 1 : 0}"
  from_port         = "22"
  to_port           = "22"
  security_group_id = "${element(module.dlp_security_group.security_group_id,0)}"
  source            = "../tf-aws-modules/security_group_rule_cidr"

  cidr_blocks = [
    "${data.aws_subnet.management_processing_a.cidr_block}"
  ]
}

module "dlp_sg_ssh_ingress_from_allstate" {
  count             = "${local.dlp_opted ==1 ? 1 : 0}"
  from_port         = "22"
  to_port           = "22"
  security_group_id = "${element(module.dlp_security_group.security_group_id,0)}"
  source            = "../tf-aws-modules/security_group_rule_cidr"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

module "dlp_sg_dlp_ingress" {
  count             = "${local.dlp_opted ==1 ? 1 : 0}"
  from_port         = "8080"
  to_port           = "8080"
  security_group_id        = "${element(module.dlp_security_group.security_group_id,0)}"
  source_security_group_id = "${element(module.elb_security_group.security_group_id,0)}"
  source                   = "../tf-aws-modules/security_group_rule_source_sg"
}

module "dlp_sg_enforce_ingress" {
  count             = "${local.dlp_opted ==1 ? 1 : 0}"
  from_port         = "8110"
  to_port           = "8110"
  security_group_id = "${element(module.dlp_security_group.security_group_id,0)}"
  source            = "../tf-aws-modules/security_group_rule_cidr"

  cidr_blocks = [
    "${var.enforce_server_ip_address}"
  ]
}

module "dlp_sg_egress_enforce" {
  count             = "${local.dlp_opted ==1 ? 1 : 0}"
  rule_type         = "egress"
  from_port         = "8110"
  to_port           = "8110"
  security_group_id = "${element(module.dlp_security_group.security_group_id,0)}"
  source            = "../tf-aws-modules/security_group_rule_cidr"
  
  cidr_blocks = [
    "${var.enforce_server_ip_address}"
  ]
}