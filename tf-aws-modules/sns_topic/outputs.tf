# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "topic_id" {
  value = "${aws_sns_topic.topic.id}"
}

output "topic_arn" {
  value = "${aws_sns_topic.topic.arn}"
}
