# -----------------------------------------------------------------------------
# Create security groups for LoadBalancer
# -----------------------------------------------------------------------------

module "elb_security_group" {
  count       = "${local.dlp_opted == 1 ? 1 : 0}"
  name        = "${local.elb_security_group_name}"
  description = "Symantec CWP LB Security Group"
  vpc_id      = "${var.vpc_id}"
  tags        = "${local.tags}"
  source      = "../tf-aws-modules/security_group"
}

module "elb_sg_https_ingress" {
  count             = "${local.dlp_opted == 1 ? 1 : 0}"
  rule_type         = "ingress"
  from_port         = "443"
  to_port           = "443"
  security_group_id = "${element(module.elb_security_group.security_group_id,0)}"
  cidr_blocks       = ["0.0.0.0/0"]
  source            = "../tf-aws-modules/security_group_rule_cidr"
}

module "elb_sg_egress_dlp" {
  count             = "${local.dlp_opted == 1 ? 1 : 0}"
  rule_type         = "egress"
  from_port         = "8080"
  to_port           = "8080"
  security_group_id = "${element(module.elb_security_group.security_group_id,0)}"
  cidr_blocks       = ["0.0.0.0/0"]
  source            = "../tf-aws-modules/security_group_rule_cidr"
}
