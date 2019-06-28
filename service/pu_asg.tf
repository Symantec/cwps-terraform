# -----------------------------------------------------------------------------
# Controller Launch Configuration
# -----------------------------------------------------------------------------

module "pu_launch_configuration" {
  iam_instance_profile = "${local.pu_iam_instance_profile}"
  name_prefix          = "symantec_pu"
  ami_id               = "${local.pu_ami_id}"
  key_name             = "${var.aws_key_pair}"
  instance_type        = "${var.pu_instance_type}"
  source               = "../tf-aws-modules/launch_configuration"

  root_block_device = [
    {
      delete_on_termination = "true"
      volume_type           = "gp2"
      volume_size           = "70"
    },
  ]

  security_groups = [
    "${module.pu_security_group.security_group_id}",
  ]

  user_data = <<USERDATA
#!/bin/bash -ex

${var.proxy_host != "" ? local.proxy_setting : ""}
# LUASERVER= ${var.lua_server}
cat > /usr/local/symantec/spe/settings/config.settings <<-EOF
Namespace=${local.symantec_namespace}
Region=${var.aws_region}
EnableLUA=No
LUAServer=${var.lua_server}
NEW_SERVER_ADDR=scwp.securitycloud.symantec.com
NEW_PORT=443
NEW_SERVICE_PORTAL_NAME=dcs-service
NEW_PROTOCOL=https
PROXY_MODE=${var.proxy_host != "" ? "Manual" : "Disabled"}
PROXY_ADDR=${var.proxy_host != "" ? local.proxy_address : ""}
PROXY_USERNAME=${var.proxy_user}
PROXY_PASSWORD=${var.proxy_password}

EOF


cat > /usr/local/symantec/spe/spe-s3-protection-adapter-service/config/config.properties <<-EOF
spe.dbclient.dynamodb.ep=
spe.s3.namespace=${local.symantec_namespace}
spe.s3.applicationevent.loglevel=
spe.s3.region=${var.aws_region}
spe.instance.id=
spe.s3.proxy.host=${var.proxy_host}
spe.s3.proxy.port=${var.proxy_port}
spe.s3.proxy.user=${var.proxy_user}
spe.s3.keystore.path=
spe.s3.password.path=
spe.s3.proxy.encpassword=

EOF

chown speservice:speservice /usr/local/symantec/spe/spe-s3-protection-adapter-service/config/config.properties
chmod 0640 /usr/local/symantec/spe/spe-s3-protection-adapter-service/config/config.properties

/usr/local/symantec/spe/settings/set_syslog_config.sh

/usr/local/symantec/spe/settings/cw-agent-conf.sh

/usr/local/symantec/spe/settings/update_prefetch_count.sh

/usr/local/symantec/spe/settings/service_start.sh awslogs

/usr/local/symantec/spe/settings/set_spe_config.sh

sudo /bin/sh /etc/rc.d/rc.local

/usr/local/symantec/spe/settings/set_spe_container_params_start_spe.sh

python /usr/local/symantec/spe/settings/GetSettingsFromDB.py ADAPTER

/usr/local/symantec/spe/settings/callcheckAVUpdated.sh &

/usr/local/symantec/spe/settings/set_cron_job.sh

/usr/local/symantec/spe/settings/empty_confidential_details.sh

USERDATA
}

module "pu_asg" {
  name                    = "${local.pu_autoscaling_group_name}"
  launch_configuration_id = "${module.pu_launch_configuration.launch_configuration_name}"
  vpc_zone_identifier     = ["${data.aws_subnet.management_processing_a.id}"]
  max_size                = "${var.pu_asg_max_size}"
  min_size                = "${var.pu_asg_min_size}"
  desired_capacity        = "${var.pu_asg_desired_size}"
  asg_tags                = ["${local.asg_tags}"]
  source                  = "../tf-aws-modules/autoscaling_group"
}

module "pu_asg_lifecycle_hook" {
  name                    = "${local.pu_autoscaling_lifecycle_name}"
  autoscaling_group_name  = "${module.pu_asg.name}"
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = "${data.aws_sns_topic.alert.arn}"
  role_arn                = "${data.aws_iam_role.alarm_notification.arn}"
  heartbeat_timeout       = "1200"
  source                  = "../tf-aws-modules/autoscaling_group_lifecycle_hook"
}
