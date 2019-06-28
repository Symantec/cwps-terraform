# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "application_name" {
  description = "Name for the application"
}

variable "arp_classification" {
  description = "ARP Classification"
}

variable "barometer_it_number" {
  description = "Barameter IT Number"
}

variable "biso" {
  description = "BISO"
}

variable "cost_center" {
  description = "Cost Center"
}

variable "dcio" {
  description = "DCIO Identifier"
}

variable "environment" {
  description = "Environment for deployemnt"
}

variable "product_owner" {
  description = "Product Owner"
}

variable "vpc_id" {
  description = "Provide VPC ID"
}

variable "subnet_id" {
  description = "Provide Subnet ID"
}

variable "aws_key_pair" {
  description = "Name of the AWS Key Pair"
}

variable "logs_retention_period" {
  description = "Log retention period"
  default="7"
}

variable "lua_server" {
  description = "LiveUpdate Administrator (LUA) Configuration"
  default = ""
}

variable "symantec_customer_id" {
  description = "Symantec Customer Id"
}

variable "symantec_domain_id" {
  description = "Symantec Domain Id"
}

variable "symantec_client_value" {
  description = "Symantec Customer Client Value"
}

variable "proxy_host" {
  description = "Provide proxy server IP address"
  default = ""
}
    
variable "proxy_port" {
  description = "Provide port to connect to proxy server. Specify value as 0 if no proxy configuration is required.",
  default="0"
}
    
variable "proxy_user" {
  description = "If using authenticated mode, provide proxy user name"
  default=""
}
    
variable "proxy_password" {
  description = "Provide password for authentication to proxy server"
  default=""
}

variable "cli_password" {
  description = "DLP Detection Appliance CLI password"
}

variable "cli_enable_password" {
  description = "DLP Detection Appliance CLI enable mode password"
}

variable "client_certificate_path" {
  description = "Provide s3 path truststore for DLP detector in format s3://<bucketname>/path-of-p12 file"
}
    
variable "certificate_pass_phrase" {
  description = "Provide password for accessing the DLP detector truststore p12 file"
}
    
variable "application_configuration_id" {
  description = "Provide application configuration id from DLP enforce server"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "aws_region" {
  description = "AWS Region for deployment"
}

variable "controller_asg_min_size" {
  description = "Controller ASG Min Size"
  default     = "1"
}

variable "controller_asg_desired_size" {
  description = "Controller ASG Desired Size"
  default     = "1"
}

variable "controller_asg_max_size" {
  description = "Controller ASG Max Size"
  default     = "2"
}

variable "pu_asg_min_size" {
  description = "PU ASG Min Size"
  default     = "1"
}

variable "pu_asg_desired_size" {
  description = "PU ASG Desired Size"
  default     = "1"
}

variable "pu_asg_max_size" {
  description = "PU ASG Max Size"
  default     = "2"
}

variable "controller_instance_type" {
  description = "Controller Instance Size"
  default     = "m4.large"
}

variable "pu_instance_type" {
  description = "PU Instance Size"
  default     = "c4.xlarge"
}

variable "assign_public_ip" {
  description = "Assign Public IP Address to Detection Appliance instances."
  default     = "true"
}

variable "dlp_instance_type" {
  description = "Select desired instance type for DLP Detection Appliance"
  default     = "t2.2xlarge"
}

variable "dlp_instance_count" {
  description = "Select desired number of DLP Detection Appliance EC2 instances to launch." 
  default     = "2"
}

variable "enforce_server_ip_address" {
  description = "Lockdown access to port 8110 of DLP Detection Appliances  (default can be accessed from anywhere)"
  default     = "0.0.0.0/0"
}

variable "dlp_amis" {
  type = "map"
  default = {
    "us-east-1"       = "ami-006723565864abe30"
    "us-east-2"       = "ami-0f4a4ff5fe286c540"
    "us-west-1"       = "ami-058d5edda2716f108"
    "us-west-2"       = "ami-030f0ce7e75e63ea5"
    "eu-west-1"       = "ami-03372e86fe4e012bb"
    "eu-west-2"       = "ami-0dbf9894fb0b461e2"
    "eu-central-1"    = "ami-067b53fb50975e4fd"
    "ap-south-1"      = "ami-08ee3195f4b2e072e"
    "ap-southeast-1"  = "ami-0a7da14e99f46a33a"
    "ap-southeast-2"  = "ami-0a5a1a631585c85b5"
    "ap-northeast-1"  = "ami-0e6f8843bc9fe4911"
    "ap-northeast-2"  = "ami-06b05692424ab829d"
    "sa-east-1"       = "ami-048e3e38de9fa5181"
    "ca-central-1"    = "ami-076eb9fd44d08456a"
  }
}

variable "cu_amis" {
  type = "map"
  default = {
    "ap-south-1" = "ami-0e5bf8fa425e1318a"
    "eu-west-2" = "ami-01b570aad5c7dd857"
    "eu-west-1" = "ami-0d07c300fc9d12efd"
    "ap-northeast-2" = "ami-0753ba9ae514c90fb"
    "ap-northeast-1" = "ami-0ac3f26cb16b686d4"
    "sa-east-1" = "ami-00a840eb32bfb8376"
    "ca-central-1" = "ami-0e1a778ab9481ceca"
    "ap-southeast-1" = "ami-0fa9c41b1e5b066b9"
    "ap-southeast-2" = "ami-0a3cefe2f3d32de20"
    "eu-central-1" = "ami-0521ecee241b52139"
    "us-east-1" = "ami-082e11ce2889e8f25"
    "us-east-2" = "ami-0dfd08bdeed4e73b3"
    "us-west-1" = "ami-0104d4f4bf118cbf5"
    "us-west-2" = "ami-075fb97c24c5660d2"
  }
}
variable "pu_amis" {
  type = "map"
  default = {
    "ap-south-1" = "ami-05cbfb8151cbb36f3"
    "eu-west-2" = "ami-0dfdaf7591d0cc1e3"
    "eu-west-1" = "ami-0f8e4cb93dd0ee858"
    "ap-northeast-2" = "ami-067dcb46603dbbdba"
    "ap-northeast-1" = "ami-0ff23db4daf0c1a9f"
    "sa-east-1" = "ami-0a413faf44cb71d0b"
    "ca-central-1" = "ami-0b8cffe348781a301"
    "ap-southeast-1" = "ami-00b87855e5939644d"
    "ap-southeast-2" = "ami-0404a584911d2bc04"
    "eu-central-1" = "ami-06a096b6c75595dc2"
    "us-east-1" = "ami-000b9738c13d60d5c"
    "us-east-2" = "ami-04a22a5cbf12e0af6"
    "us-west-1" = "ami-04024ad1b0fa6dc0e"
    "us-west-2" = "ami-0613bef8783209c16"
  }
}