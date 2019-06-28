# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "dcio" {
  description = "DCIO Identifier"
}

variable "environment" {
  description = "Environment for deployemnt"
}

variable "barometer_it_number" {
  description = "Barameter IT Number"
}

variable "arp_classification" {
  description = "ARP Classification"
}

variable "biso" {
  description = "BISO"
}

variable "product_owner" {
  description = "Product Owner"
}

variable "cost_center" {
  description = "Cost Center"
}

variable "application_name" {
  description = "Name for the application"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "aws_region" {
  description = "AWS Region for deployment"
 }

