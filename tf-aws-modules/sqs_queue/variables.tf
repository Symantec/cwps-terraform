# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "queue_name" {
  description = "The human readable name of the queue."
}

variable "kms_master_key_id" {
  description = "The KMS Key to encrypt the contents of the queue"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue in seconds. Default is 30"
  default     = 30
}

variable "message_retention_seconds" {
  description = "The message retention for the queue in seconds. Default is 60"
  default     = 60
}

variable "max_message_size" {
  description = "The maximum size of message for the queue. Default is 262144 bytes"
  default     = 262144
}

variable "delay_seconds" {
  description = "The delay for all messages in the queue in seconds. Default is 0"
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "The wait time for a receive message call in seconds. Default is 0"
  default     = 0
}

variable "fifo_queue" {
  description = "FIFO queue? Default is false"
  default     = "false"
}

variable "kms_data_key_reuse_period_seconds" {
  description = "Length of time in seconds SQS can reuse a data key to encrypt or decrypt messages. Default is 300"
  default     = 300
}

variable "tags" {
  type    = "map"
  default = {}
}
