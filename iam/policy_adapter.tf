# -----------------------------------------------------------------------------
# Symantec CWP PU Role
# -----------------------------------------------------------------------------

module "pu_role" {
  role_name = "${local.pu_iam_policy_name}"
  role_path = "/PU/"
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
  }]
}
ROLEPOLICY
}

module "pu_instance_profile" {
  instance_profile_name = "${local.pu_iam_instance_profile}"
  instance_profile_path = "/PU/"
  iam_role              = "${module.pu_role.role_name}"
  source                = "../tf-aws-modules//iam_instance_profile"
}

module "pu_s3_policy" {
  policy_name = "${local.symantec_namespace}-SPES3PolicyPU"
  source      = "../tf-aws-modules//iam_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:ListAllMyBuckets",
        "s3:GetBucketNotification",
        "s3:PutBucketNotification",
        "s3:GetBucketLocation",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:PutObjectVersionAcl",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetObjectAcl",
        "s3:GetObjectVersionAcl",
        "s3:DeleteObject",
        "s3:DeleteObjectVersion",
        "s3:GetBucketVersioning",
        "s3:GetObjectTagging",
        "s3:GetObjectVersionTagging",
        "s3:PutObjectTagging",
        "s3:PutObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::*"
      ]
    }
  ]
}
POLICY
}

module "pu_specific_policy" {
  policy_name = "${local.symantec_namespace}-SPEPUSpecificPolicy"
  source      = "../tf-aws-modules//iam_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:PutItem"
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
        "autoscaling:SetInstanceHealth",
        "autoscaling:PutLifecycleHook",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLifecycleHooks",
        "autoscaling:CompleteLifecycleAction",
        "autoscaling:RecordLifecycleActionHeartbeat",
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}

module "pu_s3_policy_attachment" {
  role       = "${module.pu_role.role_name}"
  policy_arn = "${module.pu_s3_policy.policy_arn}"
  source     = "../tf-aws-modules//iam_role_policy_attachment"
}

module "pu_specific_policy_attachment" {
  role       = "${module.pu_role.role_name}"
  policy_arn = "${module.pu_specific_policy.policy_arn}"
  source     = "../tf-aws-modules//iam_role_policy_attachment"
}

module "pu_cloudwatch_policy_attachement" {
  role       = "${module.pu_role.role_name}"
  policy_arn = "${module.scwp_cloudwatch_log_policy.policy_arn}"
  source     = "../tf-aws-modules//iam_role_policy_attachment"
}
