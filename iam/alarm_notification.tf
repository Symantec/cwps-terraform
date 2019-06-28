# -----------------------------------------------------------------------------
# Symantec CWP Alarm Notifiaction Role
# -----------------------------------------------------------------------------

module "alarm_notification_role" {
  name   = "${local.alarm_notification_iam_policy_name}"
  source = "../tf-aws-modules/iam_role_with_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage",
        "sqs:GetQueueUrl",
        "sns:Publish"
      ],
      "Resource": "*"
    }
  ]
}
POLICY

  assume_role_policy = <<ASSUME_ROLE_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "autoscaling.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
ASSUME_ROLE_POLICY
}
