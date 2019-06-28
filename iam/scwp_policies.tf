# -----------------------------------------------------------------------------
# Symantec CWP IAM Policies
# -----------------------------------------------------------------------------

module "scwp_cloudwatch_log_policy" {
  policy_name = "${local.symantec_namespace}-SPECloudWatchLogsCreatePolicy"
  source      = "../tf-aws-modules/iam_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams",
        "logs:DescribeLogGroups",
        "logs:FilterLogEvents",
        "logs:GetLogEvents",
        "logs:PutRetentionPolicy"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:*"
      ]
    }
  ]
}
POLICY
}
