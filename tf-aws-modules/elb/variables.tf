# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name of the ELB"
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ELB"
  type        = "list"
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type        = "list"
}

variable "listener" {
  description = "A list of listener blocks"
  type        = "list"
}

variable "health_check" {
  description = "A health check block"
  type        = "list"
}

variable "count" {
  description = "Condition for DLP deployment"
}
# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "internal" {
  description = "If true, ELB will be an internal ELB"
  default     = true
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  default     = false
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  default     = 60
}

variable "connection_draining" {
  description = "Boolean to enable connection draining"
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain"
  default     = 300
}

variable "access_logs" {
  description = "An access logs block"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "instances" {
  description = "A list of DLP instances to be added to loadbalancer"
  type        = "list"
  default     = []
}
