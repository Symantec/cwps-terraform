# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "policy_name" {
  description = "Name of IAM Policy"
}

variable "policy" {
  description = "IAM Policy document"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "policy_path" {
  description = "The policy path. Default is /"
  default     = "/"
}

variable "policy_description" {
  description = "Description of the IAM Policy"
  default     = ""
}
