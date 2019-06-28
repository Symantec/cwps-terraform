# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "instance_profile_name" {
  description = "The Instance Profile name"
}

variable "iam_role" {
  description = "The IAM Role to associate with the Instnace Profile"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "instance_profile_path" {
  description = "The Instance Profile Path. Default is /"
  default     = "/"
}
