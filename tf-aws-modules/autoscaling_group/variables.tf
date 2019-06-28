# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name for the AutoScaling Group"
}

variable "launch_configuration_id" {
  description = "The Launch Configuration Id for the AutoScaling Group"
}

variable "vpc_zone_identifier" {
  description = "A list of Subnet Ids to launch resources in."
  type        = "list"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "desired_capacity" {
  description = "Desired capacity for the AutoScaling Group"
  default     = "1"
}

variable "health_check_grace_period" {
  description = "Health check grace period for the AutoScaling Group"
  default     = "30"
}

variable "health_check_type" {
  description = "Health check type for the AutoScaling Group"
  default     = "EC2"
}

variable "max_size" {
  description = "Maximum size for the AutoScaling Group"
  default     = "2"
}

variable "min_size" {
  description = "Minimum size for the AutoScaling Group"
  default     = "1"
}

variable "default_cooldown" {
  description = "The amount of time in seconds after a scaling activity completes before another one will start"
  default     = "300"
}

variable "load_balancers" {
  description = "A list of load balancers to add to the AutoScaling Group"
  type        = "list"
  default     = []
}

variable "target_group_arns" {
  description = "A list of target group ARNs to register instances from the AutoScaling Group"
  type        = "list"
  default     = []
}

variable "asg_tags" {
  description = "A list of AutoScaling Group tags to apply to instances"
  type        = "list"
  default     = []
}

variable "enabled_metrics" {
  description = "List of metrics to collect: GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = "list"
  default     = []
}
