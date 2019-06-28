# Launch Configuration

## Usage

```hcl
module "ec2_dlp_instance" {
  instance_count            = ""
  ami_id                    = "ami-1234adsf"
  security_groups           = ["sg-1234asdf", "sg-asdf1234"]
  subnet_id                 = 
  source                    = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//dlp_instance"

  user_data = <<USERDATA
{
"password": "Admin#123",
"enable_password": "Admin#123"
}
USERDATA
}
```

## Required Variables

* `ami_id`: The AMI Id to use for the DLP Instance
* `user_data`: User data for setting CLI and Enable password
* `security_groups`: A list of security groups for the DLP Instance

## Optional Variables

* `instance_type`: The Instance Type for the DLP Instance. Default is t2.2xlarge
* `associate_public_ip_address`: Associate a public IP address with the instances. Default is false.
* `ebs_block_device`: A list of maps for EBS block devices. Default is one 50GB gp2 device with a device name /dev/sda1 which will be deleted on termination.

## Outputs

* `dlp_instance_ids`: The list of Ids of the DLP Instances

## Terraform Resources

* [aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)
