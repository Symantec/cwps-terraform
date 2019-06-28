# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "name_prefix" {
  description = "prefix for the name of the launch config"
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile for the Launch Configuration"
}

variable "ami_id" {
  description = "The AMI Id to use for the Launch Configuration"
}

variable "key_name" {
  description = "The Key name for the instances launched"
}

variable "user_data" {
  description = "The user data for the Launch Configuration"
}

variable "security_groups" {
  description = "A list of security groups for the Launch Configuration"
  type        = "list"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "instance_type" {
  description = "The Instance Type for the Launch Configuration. Default is t2.medium"
  default     = "t2.medium"
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address with the instances"
  type        = "string"
  default     = "true"
}

variable "root_block_device" {
  description = "Root block device for the instances"
  type        = "list"

  default = [
    {
      delete_on_termination = "true"
      volume_type           = "gp2"
      volume_size           = "20"
    },
  ]
}

variable "ebs_block_device" {
  description = "EBS block devices for the instances"
  type        = "list"

  default = [
    {
      delete_on_termination = "true"
      volume_type           = "gp2"
      volume_size           = "60"
      device_name           = "/dev/sdb"
    },
  ]
}
