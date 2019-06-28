# -----------------------------------------------------------------------------
# Create security groups for PU instances
# -----------------------------------------------------------------------------

module "pu_security_group" {
  count       = "1"
  name        = "${local.pu_security_group_name}"
  description = "Symantec CWP PU Security Group"
  vpc_id      = "${var.vpc_id}"
  tags        = "${local.tags}"
  source      = "../tf-aws-modules/security_group"
}

module "pu_sg_ssh_ingress" {
  count             = "1"
  from_port         = "22"
  to_port           = "22"
  security_group_id = "${element(module.pu_security_group.security_group_id,0)}"
  source            = "../tf-aws-modules/security_group_rule_cidr"

  cidr_blocks = [
    "${data.aws_subnet.management_processing_a.cidr_block}"
  ]
}

module "pu_sg_ssh_ingress_from_allstate" {
  count             = "1"
  from_port         = "22"
  to_port           = "22"
  security_group_id = "${element(module.pu_security_group.security_group_id,0)}"
  source            = "../tf-aws-modules/security_group_rule_cidr"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

module "pu_sg_egress_dns" {
  count             = "1"
  rule_type         = "egress"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${element(module.pu_security_group.security_group_id,0)}"
  cidr_blocks       = ["0.0.0.0/0"]
  source            = "../tf-aws-modules/security_group_rule_cidr"
}

module "pu_sg_egress_dns_udp" {
  count             = "1"
  rule_type         = "egress"
  protocol          = "udp"
  from_port         = "53"
  to_port           = "53"
  security_group_id = "${element(module.pu_security_group.security_group_id,0)}"
  cidr_blocks       = ["0.0.0.0/0"]
  source            = "../tf-aws-modules/security_group_rule_cidr"
}

module "pu_sg_egress_http" {
  count             = "1"
  rule_type         = "egress"
  from_port         = "80"
  to_port           = "80"
  security_group_id = "${element(module.pu_security_group.security_group_id,0)}"
  cidr_blocks       = ["0.0.0.0/0"]
  source            = "../tf-aws-modules/security_group_rule_cidr"
}

module "pu_sg_egress_https" {
  count             = "1"
  rule_type         = "egress"
  from_port         = "443"
  to_port           = "443"
  security_group_id = "${element(module.pu_security_group.security_group_id,0)}"
  cidr_blocks       = ["0.0.0.0/0"]
  source            = "../tf-aws-modules/security_group_rule_cidr"
}

module "pu_sg_ingress_5671" {
  count                    = "1"
  rule_type                = "egress"
  from_port                = "5671"
  to_port                  = "5671"
  security_group_id        = "${element(module.pu_security_group.security_group_id,0)}"
  source_security_group_id = "${element(module.controller_security_group.security_group_id,0)}"
  source                   = "../tf-aws-modules/security_group_rule_source_sg"
}
