# -----------------------------------------------------------------------------
# Symantec CWP Controller Role
# -----------------------------------------------------------------------------

module "controller_role" {
  role_name = "${local.controller_iam_policy_name}"
  role_path = "/Controller/"
  source    = "../tf-aws-modules/iam_role"
  assume_role_policy = <<ROLEPOLICY
{
  "Version": "2012-10-17",
  "Statement": [{
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      }
    }
  ]
}
ROLEPOLICY
}

module "controller_instance_profile" {
  instance_profile_name = "${local.controller_iam_instance_profile}"
  instance_profile_path = "/Controller/"
  iam_role              = "${module.controller_role.role_name}"
  source                = "../tf-aws-modules//iam_instance_profile"
}

module "controller_s3_policy" {
  policy_name = "${local.symantec_namespace}-SPES3PolicyController"
  source      = "../tf-aws-modules//iam_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:DeleteObjectVersion",
        "s3:GetObjectVersionTagging",
        "s3:PutObjectVersionAcl",
        "s3:PutObjectVersionTagging",
        "s3:GetObjectTagging",
        "s3:PutObjectTagging",
        "s3:GetBucketVersioning",
        "s3:DeleteObject",
        "s3:PutObjectAcl",
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:ListAllMyBuckets",
        "s3:GetBucketNotification",
        "s3:PutBucketNotification",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetObjectAcl",
        "s3:GetObjectVersionAcl",
        "s3:DeleteObject",
        "s3:GetBucketAcl",
        "s3:GetBucketPolicy",
        "s3:PutBucketPolicy",
        "s3:DeleteBucketPolicy",
        "s3:GetBucketPublicAccessBlock",
        "s3:GetBucketPolicyStatus",
        "s3:GetAccountPublicAccessBlock"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    }
  ]
}
POLICY
}

module "controller_specific_policy" {
  policy_name = "${local.symantec_namespace}-SPEControllerSpecificPolicy"
  source      = "../tf-aws-modules//iam_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:UpdateItem",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:BatchWriteItem"
      ],
      "Effect": "Allow",
      "Resource": [
        "${data.aws_dynamodb_table.asset.arn}",
        "${data.aws_dynamodb_table.discovered_assets.arn}",
        "${data.aws_dynamodb_table.command.arn}",
        "${data.aws_dynamodb_table.controller_schedule.arn}",
        "${data.aws_dynamodb_table.job.arn}",
        "${data.aws_dynamodb_table.metering_data.arn}",
        "${data.aws_dynamodb_table.settings.arn}",
        "${data.aws_dynamodb_table.remediation_details.arn}",
        "${data.aws_dynamodb_table.remediation_exception.arn}",
        "${data.aws_dynamodb_table.sync_object_stats.arn}",
        "${data.aws_dynamodb_table.user_schedule.arn}",
        "${data.aws_dynamodb_table.role_arns.arn}",
        "${data.aws_dynamodb_table.properties.arn}"
      ]
    },
    {
      "Action": [
        "cloudwatch:PutMetricData",
        "cloudwatch:PutMetricAlarm"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "autoscaling:putScalingPolicy",
        "autoscaling:DescribePolicies",
        "autoscaling:SetInstanceHealth",
        "autoscaling:describeAutoScalingGroups",
        "autoscaling:setDesiredCapacity",
        "autoscaling:PutLifecycleHook",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLifecycleHooks",
        "autoscaling:CompleteLifecycleAction",
        "autoscaling:RecordLifecycleActionHeartbeat",
        "autoscaling:UpdateAutoScalingGroup", 
        "sts:AssumeRole",
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "sqs:receiveMessage",
        "sqs:deleteMessage",
        "sqs:PurgeQueue",
        "sqs:setQueueAttributes"
      ],
      "Effect": "Allow",
      "Resource": [
        "${module.sqs_access_queue.queue_arn}"
      ]
    },
    {
      "Action": [
        "sns:createTopic",
        "sns:subscribe",
        "sns:setTopicAttributes"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${local.symantec_namespace}*"
      ]
    }
  ]
}
POLICY
}

module "controller_s3_policy_attachment" {
  role       = "${module.controller_role.role_name}"
  policy_arn = "${module.controller_s3_policy.policy_arn}"
  source     = "../tf-aws-modules//iam_role_policy_attachment"
}

module "controller_specific_policy_attachment" {
  role       = "${module.controller_role.role_name}"
  policy_arn = "${module.controller_specific_policy.policy_arn}"
  source     = "../tf-aws-modules//iam_role_policy_attachment"
}

module "controller_scwp_cloudwatch_policy_attachment" {
  role       = "${module.controller_role.role_name}"
  policy_arn = "${module.scwp_cloudwatch_log_policy.policy_arn}"
  source     = "../tf-aws-modules//iam_role_policy_attachment"
}
