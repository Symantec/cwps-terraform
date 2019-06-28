# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "role_name" {
  description = "The name of the role"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "role_description" {
  description = "The description for the role. Default is an empty string"
  default     = ""
}

variable "assume_role_policy" {
  description = "The AWS Service for the role. Default is ec2"

  default = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

variable "role_path" {
  description = "The path to the role"
  default     = "/"
}
