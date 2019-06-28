# Cloud Workload Protection for Storage

## Usage

* Deploy the resources using terraform in following order -
  * Prepare variable-value (key-pair) set in 'terraform.tfvars' for each set - infra, iam, service. Refer to Variables section for more details.
  * Set access_key, secret_key and region in environment or update/add these in provider.tf in each set - infra, iam, service. 
  * cd infra -> init and apply the plan with variables values from 'terraform.tfvars'.
  * cd iam -> init and apply the plan with variables values from 'terraform.tfvars'.
  * cd service -> init and apply the plan with variables values from 'terraform.tfvars'.

## Required Variables

* `application_name` : Application Name 
* `arp_classification`: Arp classification
* `barometer_it_number` : Barometer IT number
* `biso` : Business Information Security Officer
* `cost_center` : Cost Center
* `dcio` : DCIO
* `environment` : Environment
* `product_owner` : Product Owner
* `vpc_id` : VPC ID is a mandatory input parameter. Provide an existing VPC ID.
* `subnet_id` : Provide existing subnet id from the selected VPC.
* `aws_key_pair` : Select an existing key pair to access EC2 instance.
* `logs_retention_period` : Select the number of days to retain CloudWatch log groups.
* `lua_server` : Enter an IP address of the LUA server that you want to use.
* `symantec_customer_id` = "your customer id"
* `symantec_domain_id` = "your domain id"
* `symantec_client_value` = "your key"
* `proxy_host` : Provide proxy server IP address.
* `proxy_port` : Provide port to connect to proxy server. Specify value as 0 if no proxy configuration is required.
* `proxy_user` : If using authenticated mode, provide proxy user name.
* `proxy_password` : Provide password for authentication to proxy server.
* `cli_password` : DLP Detection Appliance CLI password.
* `cli_enable_password` : DLP Detection Appliance CLI enable mode password.
* `client_certificate_path` : Provide s3 path of certificate in format - s3://<bucketname>/path-of-p12 file
* `certificate_pass_phrase` : Provide password for accessing the certificate
* `application_configuration_id` : Provide application configuration id.

## Optional Variables

* `aws_region` : AWS Region for deployment. 
    * default = "us-west-2"
    * allowed values = {
        * ap-south-1
        * eu-west-2
        * eu-west-1
        * ap-northeast-2
        * ap-northeast-1
        * sa-east-1
        * ca-central-1
        * ap-southeast-1
        * ap-southeast-2
        * eu-central-1
        * us-east-1
        * us-east-2
        * us-west-1
        * us-west-2
      }
* `controller_asg_min_size` : Controller AutoScaling Group Min Size. 
    * default = "1"
    * Enter any value from 0 to 20.
* `controller_asg_desired_size` : Controller AutoScaling Group Desired Size. 
    * default = "1"
    * Enter any value from 1 to 20.
* `controller_asg_max_size` : Controller ASG Max Size.
    * default = "2"
* `pu_asg_min_size` : PU ASG Min Size.
    * default = "1"
* `pu_asg_desired_size` : PU ASG Desired Size.
    * default = "1"
    * Enter any value from 0 to 20. Desired PU Instances must be between Minimum PU Instances and Maximum PU Instances values.
* `pu_asg_max_size` : PU ASG Max Size".
    * default = "2"
    * Enter any value from 1 to 20.
* `controller_instance_type` : Controller Instance Size. 
    * default = "m4.large"
    * allowed values = {
        "m4.large", "m4.xlarge", "m4.2xlarge", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "t3.medium", "t3.xlarge", "m5.large", "m5.xlarge", "m5.2xlarge", "m5d.xlarge"
      }
* `pu_instance_type` : PU Instance Size. 
    * default = "c4.xlarge"
    * allowed values = {
        "m4.large", "m4.xlarge", "m4.2xlarge", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "t3.xlarge", "m5.large", "m5.xlarge", "m5.2xlarge", "c5.xlarge", "c5.2xlarge", "c5.4xlarge", "c5d.xlarge", "c5d.2xlarge"
      }
* `assign_public_ip` : Assign Public IP Address to Detection Appliance instances.
    * default = "true"
    * Set this to false to confine DLP EC2 instances to private network.
* `dlp_instance_type` : Select desired instance type for DLP Detection Appliance. 
    * default = "t2.2xlarge"
    * allowed values = {
        "t2.xlarge", "t2.2xlarge", "m4.large", "m4.xlarge", "m4.2xlarge", "m4.4xlarge", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "i3.xlarge", "i3.2xlarge", "i3.4xlarge"
      }
* `dlp_instance_count` : Select desired number of DLP Detection Appliance EC2 instances to launch. 
    * default = "2"
* `enforce_server_ip_address` : Lockdown access to port 8110 of DLP Detection Appliances  (default can be accessed from anywhere) 
    * default = "0.0.0.0/0"


## terraform.tfvars example


* application_name = "cwpsterraform"
* arp_classification = "classification"
* barometer_it_number = "000000"
* biso = "BISO"
* cost_center = "Groupware"
* dcio = "DCIO"
* environment = "prod"
* product_owner = "Atul_Ghodke"
* vpc_id = "vpc-8000xxx4"
* subnet_id = "subnet-5d0xxxxb"
* aws_key_pair = "TestAutomation"
* logs_retention_period = "7"
* lua_server = ""
* symantec_customer_id = "your customer id"
* symantec_domain_id = "your domain id"
* symantec_client_value = "your client key"
* proxy_host = ""
* proxy_port = "0"
* proxy_user = ""
* proxy_password = ""
* cli_enable_password = "P@ssword#123"
* cli_password = "P@ssword#123"
* client_certificate_path = "s3://dlpvaultbucket/DLP/clientkeystore.p12"
* certificate_pass_phrase = "P@ssPh&s3"
* application_configuration_id  = "adc10507-9c21-4b2b-b7xc-810ekg271ea2"
* enforce_server_ip_address = "18.36.111.120/32"

## Notes

* If proxy is not setup and used set proxy parameters to empty values except `proxy_port` which needs to be set as "0".
* DLP parameters should be set to empty values if DLP is not opted for deployment

## Help Resources

* [CWP for Storage Help](https://help.symantec.com/home/SCWP?locale=EN_US&set=CWP_STORAGE)
