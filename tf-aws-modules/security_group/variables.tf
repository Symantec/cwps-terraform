# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name of the security group"
}

variable "description" {
  description = "The description for the security group"
}

variable "vpc_id" {
  description = "The VPC to associate with the security group"
}

variable "count" {
  description = "Condition for deployment"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "tags" {
  description = "The tags to associate with the security group"
  type        = "map"
  default     = {}
}
