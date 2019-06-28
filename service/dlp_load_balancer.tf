# -----------------------------------------------------------------------------
# Elastic Load Balancer for DLP Instances
# -----------------------------------------------------------------------------

module "dlp_load_balancer" {
  count                       = "${local.dlp_opted ==1 ? 1 : 0}"
  name                        = "${local.elb_name}"
  subnets                     = ["${data.aws_subnet.management_processing_a.id}"]
  security_groups             = ["${module.elb_security_group.security_group_id}"]
  internal                    = true
  cross_zone_load_balancing   = false
  source                      = "../tf-aws-modules/elb"
  tags                        = "${local.tags}"
  
  listener = [{
    instance_port     = 8080
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }]
  
  health_check = [{
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "TCP:8080"
    interval            = 30
  }]
  
  # The instances are registered automatically
  instances = ["${module.dlp_instance.dlp_instance_id}"]
}
