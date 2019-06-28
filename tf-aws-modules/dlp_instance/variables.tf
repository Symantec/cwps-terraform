# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name for the DLP instances"
}

variable "ami_id" {
  description = "The AMI Id to use for the DLP Detector instances"
}

variable "subnet_id" {
  description = "The Subnet Id to use for the DLP Detector instances"
}

variable "user_data" {
  description = "The user data for the DLP Detector instances"
}

variable "security_groups" {
  description = "A list of security groups for the DLP Detector instances"
  type        = "list"
}

variable "count" {
  description = "Condition for deployment"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "instance_type" {
  description = "The Instance Type for the DLP Detector instances. Default is t2.2xlarge"
  default     = "t2.2xlarge"
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address with the instances"
  type        = "string"
  default     = "true"
}

variable "ebs_block_device" {
  description = "EBS block devices for the instances"
  type        = "list"

  default = [
    {
      delete_on_termination = "true"
      volume_type           = "gp2"
      volume_size           = "50"
      device_name           = "/dev/sda1"
    },
  ]
}

variable "tags" {
  type    = "map"
  default = {}
}