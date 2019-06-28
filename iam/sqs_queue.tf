# -----------------------------------------------------------------------------
# KMS Key for Ecryption and Decryption of Symantec CWP SQS Queue
# -----------------------------------------------------------------------------

module "sqs_kms_key" {
  description   = "Symantec CWP SQS KMS Key"
  tags          = "${local.tags}"
  kms_key_alias = "alias/${local.symantec_namespace}-SymantecCWP-SQS"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": {
        "AWS": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        ]
      },
      "Effect": "Allow",
      "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource*",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ],
      "Resource": "*"
    },
    {
      "Principal": {
        "Service": [
          "s3.amazonaws.com",
          "sns.amazonaws.com"
        ],
        "AWS": [
          "${module.controller_role.role_arn}",
          "${module.pu_role.role_arn}"
        ]
      },
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    }
  ]
}
POLICY

  source = "../tf-aws-modules/kms_key"
}

# -----------------------------------------------------------------------------
# Symantec CWP SQS Queue
# -----------------------------------------------------------------------------

module "sqs_access_queue" {
  queue_name                 = "${local.symantec_namespace}_${local.sqs_access_queue_name}"
  kms_master_key_id          = "${module.sqs_kms_key.kms_key_id}"
  visibility_timeout_seconds = "1800"
  tags                       = "${local.tags}"
  source                     = "../tf-aws-modules/sqs_queue"
}

module "sqs_access_queue_policy" {
  queue_url = "${module.sqs_access_queue.queue_id}"
  source    = "../tf-aws-modules/sqs_queue_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "s3.amazonaws.com",
          "sns.amazonaws.com"
        ]
      },
      "Action": [
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ListQueues",
        "sqs:SendMessage"
      ],
      "Resource": "${module.sqs_access_queue.queue_arn}"
    }
  ]
}
POLICY
}
