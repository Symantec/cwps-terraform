# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name for the AutoScaling Group Lifecycle Hook"
}

variable "autoscaling_group_name" {
  description = "The name of the AutoScaling Group Name"
}

variable "lifecycle_transition" {
  description = "The instance state to which you want to attach the lifecycle hook."
}

variable "notification_target_arn" {
  description = "The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic."
}

variable "role_arn" {
  description = "The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target."
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "default_result" {
  description = "Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON. The default value for this parameter is ABANDON."
  default     = "ABANDON"
}

variable "heartbeat_timeout" {
  description = "Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter"
  default     = "3600"
}

variable "notification_metadata" {
  description = "Contains additional information that you want to include any time Auto Scaling sends a message to the notification target."
  default     = ""
}
