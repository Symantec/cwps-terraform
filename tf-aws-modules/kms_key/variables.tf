# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "description" {
  description = "A description of the KMS Key"
}

variable "policy" {
  description = "JSON policy document for the KMS Key"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "key_usage" {
  description = "Specifies the intended use of the key. Default is ENCRYPT_DECRYPT"
  default     = "ENCRYPT_DECRYPT"
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after resource destruction. Default is 30."
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable or disable key rotation. Default is false."
  default     = "false"
}

variable "kms_key_alias" {
  description = "An alias for the KMS Key. Default is empty string"
  default     = ""
}

variable "tags" {
  type    = "map"
  default = {}
}
