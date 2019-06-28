# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "from_port" {
  description = "The start port for the rule"
}

variable "to_port" {
  description = "The end port for the rule"
}

variable "security_group_id" {
  description = "The security group to associate with the rule"
}

variable "cidr_blocks" {
  description = "The CIDR blocks to include with the rule"
  type        = "list"
}

variable "count" {
  description = "Condition for deployment"
}
# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "protocol" {
  description = "The IP protocol to use for the rule. tcp, udp, icmp, or the protocol number"
  default     = "tcp"
}

variable "rule_type" {
  description = "The type of rule. egress or ingress"
  default     = "ingress"
}
