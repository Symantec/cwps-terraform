# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "role" {
  description = "The role to have the policy attached."
}

variable "policy_arn" {
  description = "ARN for the IAM Policy to attach to the role."
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

