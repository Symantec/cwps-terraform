# -----------------------------------------------------------------------------
# Controller Launch Configuration
# -----------------------------------------------------------------------------

module "controller_launch_configuration" {
  iam_instance_profile = "${local.controller_iam_instance_profile}"
  name_prefix          = "symantec_controller"
  ami_id               = "${local.controller_ami_id}"
  key_name             = "${var.aws_key_pair}"
  instance_type        = "${var.controller_instance_type}"
  source               = "../tf-aws-modules/launch_configuration"

  root_block_device = [
    {
      delete_on_termination = "true"
      volume_type           = "gp2"
      volume_size           = "70"
    },
  ]

  security_groups = [
    "${module.controller_security_group.security_group_id}",
  ]

  user_data = <<USERDATA
#!/bin/bash -ex

${var.proxy_host != "" ? local.proxy_setting : ""}
# DLPDetectorURL=${local.dlp_opted == 1 ? module.dlp_load_balancer.elb_dns_name : ""}
# DLPClientCertificatePath=${local.dlp_opted ==1 ? var.client_certificate_path : ""}
# DLPCertificatePassPhrase=${local.dlp_opted ==1 ? var.certificate_pass_phrase : ""}
# DLPApplicationConfigurationId=${local.dlp_opted ==1 ? var.application_configuration_id : ""}

cat > /usr/local/symantec/spe/spe-s3-protection-controller-service/config/config.properties <<-EOF
rabbitmq.host=127.0.0.1
rabbitmq.username=spemq
rabbitmq.port=5671
rabbitmq.usessl=true
rabbitmq.vhost=spemqvhost

file.quartz.properties=config/quartz.properties

spe.dbclient.dynamodb.ep=
spe.s3.namespace=${local.symantec_namespace}
spe.userschedules.limit=25

#FILE_MODE
scheduler.command.mode=
file.init.command=S3InitCommands.xml
file.process.command=S3SchedulerCommands.xml

#S3 Connector specific Configuration
s3.policyname=FactoryShippedPolicy
scan.exchange=spe.s3.scan.exchange
spe.s3.applicationevent.loglevel=
controlmessages.exchange=spe.s3.controlmessages.exchange
controller.event.pull.delay.timeInSec=8

#rabbit mq prop
rabbitmq.backoffpolicy.initialinterval=500
rabbitmq.backoffpolicy.maxinterval=10000
rabbitmq.backoffpolicy.multiplier=2
rabbitmq.retrypolicy.maxattempts=5

s3.eventreporter.actions.directorypath=./cwlogs/statistics
s3.eventreporter.actions.filename=statistics.log
spe.s3.region=${var.aws_region}
spe.s3.account.id=${data.aws_caller_identity.current.account_id}
spe.s3.bucket.discovery.multiaccount=No
spe.instance.id=
spe.s3.eventreporter.maxfilesize=1024MB
spe.s3.common.config.setting.file=/usr/local/symantec/spe/settings/config.settings
s3.eventreporter.scanerror.directorypath=./cwlogs/violation/scanerror
s3.eventreporter.scanerror.filename=scanerrors.log
s3.policyId=38f68cae-c6e9-4ea8-87e3-0b8ec20469f5
s3.eventreporter.controllerevent.directorypath=./cwlogs/event/controller
s3.eventreporter.controllerevent.filename=event.log
s3.eventreporter.permissions.directorypath=./cwlogs/assessment/config
s3.eventreporter.permissions.filename=permission.log

purge.jobs.duration.days=90
purge.modulo.hours=24

#Throttling
throttling.schedule.queue.max.items=100000
throttling.schedule.queue.throttle.items=1000
throttling.nrts.queue.max.items=100000
throttling.nrts.queue.throttle.items=1000

#CW Client
spe.s3.cwclient.cw.ep=
spe.s3.cwclient.cw.retryInterval=5
spe.s3.cwclient.cw.maxRetries=10
spe.s3.cwclient.cw.apiratelimit=5
spe.s3.cwclient.cw.waitForEventsInterval=120000
spe.s3.ipc.server.controller.ip=127.0.0.1
spe.s3.ipc.server.controller.port=9002
spe.s3.ipc.server.caf.ip=127.0.0.1
spe.s3.ipc.server.caf.port=9001
spe.s3.ipc.server.maxQueued=64
spe.s3.metering.timeperiod=30

event.exchange=spe.s3.event.exchange
spe.s3.ipc.events.dir=/usr/local/symantec/spe/caf-controller-ipc/events
spe.s3.events.timeperiod=30
spe.s3.proxy.host=${var.proxy_host}
spe.s3.proxy.port=${var.proxy_port}
spe.s3.proxy.user=${var.proxy_user}
spe.s3.keystore.path=
spe.s3.password.path=
spe.s3.proxy.encpassword=
aws.dynamo.batchsize=25
spe.s3.bucket.discovery.mode=${local.discovery_mode}
spe.s3.bucket.discovery.timeperiod=15
spe.s3.bucket.discovery.payload.paging=20
#Provisioning Status 
spe.s3.common.provisioning.config.file=/usr/local/symantec/spe/settings/provisioning_config.properties
EOF

chown speservice:speservice /usr/local/symantec/spe/spe-s3-protection-controller-service/config/config.properties
chmod 0640 /usr/local/symantec/spe/spe-s3-protection-controller-service/config/config.properties

cat > /usr/local/symantec/spe/command-gateway/config/config.properties <<-EOF
spe.dbclient.dynamodb.ep=
spe.s3.namespace=${local.symantec_namespace}
spe.userschedules.limit=25
spe.snsclient.reporting.topic=
spe.s3.region=${var.aws_region}
spe.s3.account.id=${data.aws_caller_identity.current.account_id}
spe.s3.bucket.discovery.multiaccount=No
spe.s3.cwclient.cw.ep=
spe.s3.cwclient.cw.retryInterval=5
spe.s3.cwclient.cw.maxRetries=10
spe.s3.cwclient.cw.apiratelimit=5
spe.cg.reportingDir=Reporting
spe.cg.reporting.batchSize=2000
spe.cg.reporting.threadsPerDay=1
spe.s3.proxy.host=${var.proxy_host}
spe.s3.proxy.port=${var.proxy_port}
spe.s3.proxy.user=${var.proxy_user}
spe.s3.keystore.path=
spe.s3.password.path=
spe.s3.proxy.encpassword=
spe.s3.bucket.discovery.mode=${local.discovery_mode}
EOF

chown speservice:speservice /usr/local/symantec/spe/command-gateway/config/config.properties
chmod 0640 /usr/local/symantec/spe/command-gateway/config/config.properties

cat > /usr/local/symantec/spe/spe-cloudwatch-rabbitmq-metric-service/config/config.properties <<-EOF
#rabbitMQ config
rabbitMQ.host=127.0.0.1
rabbitMQ.username=spemq
rabbitMQ.vhost=spemqvhost
rabbitMQ.usessl=true
rabbitMQ.sched_queue_name=FactoryShippedPolicy_SCANREQUEST_SCHEDULED
rabbitMQ.nrts_queue_name=FactoryShippedPolicy_SCANREQUEST_ONACCESSSCAN
rabbitMQ.port=5671
rabbitMQ.frequencyPutMetric=60
spe.userschedules.limit=25
spe.dbclient.dynamodb.ep=

#No. of requests SPE scans in 1 hour
NumberOfFilesSPEScansInOneHour=100000
spe.cwmetric.ep.queuelimit=400000
spe.cwmetric.ep.stackName=${local.symantec_namespace}
spe.cwmetric.ep.avginterval=4
s3.policyname=testpolicy
s3.policyId=38f68cae-c6e9-4ea8-87e3-0b8ec20469f5
s3.eventreporter.cwevent.directorypath=./cwlogs/event/cwevent
s3.eventreporter.cwevent.filename=event.log

#Health Reporting Log Level Severity specific configuration
spe.s3.applicationevent.loglevel=
spe.s3.namespace=${local.symantec_namespace}
spe.s3.region=${var.aws_region}
spe.s3.proxy.host=${var.proxy_host}
spe.s3.proxy.port=${var.proxy_port}
spe.s3.proxy.user=${var.proxy_user}
spe.s3.keystore.path=
spe.s3.password.path=
spe.s3.proxy.encpassword=
EOF

chown speservice:speservice /usr/local/symantec/spe/spe-cloudwatch-rabbitmq-metric-service/config/config.properties
chmod 0640 /usr/local/symantec/spe/spe-cloudwatch-rabbitmq-metric-service/config/config.properties

cat > /usr/local/symantec/spe/settings/config.settings <<-EOF
NRTS=Yes
KMSKey=${data.aws_kms_key.sqs_key.id}
SQSName=${local.sqs_access_queue_name}
SQS-URLink=${data.aws_sqs_queue.access.url}
LogsRetentionPeriod=${var.logs_retention_period}
CFTVersion=1.0.2.133
Namespace=${local.symantec_namespace}
Region=${var.aws_region}
ControllerInstanceType=${var.controller_instance_type}
PUInstanceType=${var.pu_instance_type}
MaxPUInstances=${var.pu_asg_max_size}
DesPUInstances=${var.pu_asg_desired_size}
MinPUInstances=${var.pu_asg_min_size}
EnableLUA=No
LUAServer=
StackName=${local.symantec_namespace}
CustomerId=${var.symantec_customer_id}
DomainId=${var.symantec_domain_id}
SecretKey=${var.symantec_client_value}
account_id=${data.aws_caller_identity.current.account_id}
ami_id=${local.controller_ami_id}
queue_arn=${data.aws_sqs_queue.access.arn}
BUCKET_CONFIGURATION_REQ=${local.bucket_configuration}
NEW_SERVER_ADDR=scwp.securitycloud.symantec.com
NEW_PORT=443
NEW_SERVICE_PORTAL_NAME=dcs-service
PROXY_MODE=${var.proxy_host != "" ? "Manual" : "Disabled"}
PROXY_ADDR=${var.proxy_host != "" ? local.proxy_address : ""}
PROXY_USERNAME=${var.proxy_user}
PROXY_PASSWORD=${var.proxy_password}
DLPDetectorURL=${local.dlp_opted ==1 ? "https://" : ""}${local.dlp_opted ? module.dlp_load_balancer.elb_dns_name : ""}
DLPClientCertificatePath=${local.dlp_opted ==1 ? var.client_certificate_path : ""}
DLPCertificatePassPhrase=${local.dlp_opted ==1 ? var.certificate_pass_phrase : ""}
DLPApplicationConfigurationId=${local.dlp_opted ==1 ? var.application_configuration_id : ""}
DLPApplianceIPs=${local.dlp_opted ==1 ? join(",",module.dlp_instance.dlp_public_ip) : ""}
CONFIG_DIR=/etc/caf
NEW_PROTOCOL=https
POLL_TIME_MINUTES=2
EOF

python /usr/local/symantec/spe/settings/telemetry_info_update.py SPEForAWSS3 symantec_ext AWS

/usr/local/symantec/spe/settings/setup-keystore-cu.sh

/usr/local/symantec/spe/settings/set_syslog_config.sh

/usr/local/symantec/spe/settings/save_dlp_certificate.sh

python /usr/local/symantec/spe/settings/FetchDLPKeyCertificateContents.py

/usr/local/symantec/spe/settings/rabbitmq_config.sh

python /usr/local/symantec/spe/settings/UpdateSettingsInDB.py

python /usr/local/symantec/spe/settings/GetSettingsFromDB.py CONTROLLER

/usr/local/symantec/spe/settings/set_cwmetricservice_loglevel.sh

/usr/local/symantec/spe/settings/autoscaling_config.sh

/usr/local/symantec/spe/settings/cw-agent-conf.sh

/usr/local/symantec/spe/settings/set_logretention_period.sh

/usr/local/symantec/spe/settings/caf_config.sh

/usr/local/symantec/spe/settings/service_start.sh awslogs

/usr/local/symantec/spe/settings/service_start.sh spe-s3-protection-controller-service

/etc/init.d/cafagent start

/usr/local/symantec/spe/settings/enroll_check.sh

/usr/local/symantec/spe/settings/service_start.sh spe-cloudwatch-rabbitmq-metric-service

/usr/local/symantec/spe/settings/set_cron_job.sh

/usr/local/symantec/spe/settings/empty_confidential_details.sh

USERDATA
}

module "controller_asg" {
  name                    = "${local.controller_autoscaling_group_name}"
  launch_configuration_id = "${module.controller_launch_configuration.launch_configuration_name}"
  vpc_zone_identifier     = ["${data.aws_subnet.management_processing_a.id}"]
  max_size                = "${var.controller_asg_max_size}"
  min_size                = "${var.controller_asg_min_size}"
  desired_capacity        = "${var.controller_asg_desired_size}"
  asg_tags                = ["${local.asg_tags}"]
  source                  = "../tf-aws-modules/autoscaling_group"
}

module "controller_asg_lifecycle_hook" {
  name                    = "${local.controller_autoscaling_lifecycle_name}"
  autoscaling_group_name  = "${module.controller_asg.name}"
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = "${data.aws_sns_topic.alert.arn}"
  role_arn                = "${data.aws_iam_role.alarm_notification.arn}"
  heartbeat_timeout       = "1200"
  source                  = "../tf-aws-modules/autoscaling_group_lifecycle_hook"
}
