# -----------------------------------------------------------------------------
# Symantec CWP Alert SNS Topic
# -----------------------------------------------------------------------------

module "alert_sns_topic" {
  name   = "${local.alert_sns_topic_name}"
  source = "../tf-aws-modules/sns_topic"
}
