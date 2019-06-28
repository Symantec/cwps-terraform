# Launch Configuration

## Usage

```hcl
module "ec2_launch_configuration" {
  iam_instance_profile      = "ec2-instance-profile"
  name_prefix               = "instance-name-"
  ami_id                    = "ami-1234adsf"
  key_name                  = "ec2-key-pair"
  security_groups           = ["sg-1234asdf", "sg-asdf1234"]
  source                    = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//launch_configuration"

  user_data = <<USERDATA
#!/bin/bash

echo "Instance Launched!"
USERDATA
}
```

## Required Variables

* `iam_instance_profile`: The IAM Instance Profile for the Launch Configuration
* `name_prefix`: prefixed named for the launch configuration to easily see it in console
* `ami_id`: The AMI Id to use for the Launch Configuration
* `key_name`: The Key name for the instances launched
* `user_data`: User data for the Launch Configuration
* `security_groups`: A list of security groups for the Launch Configuration

## Optional Variables

* `instance_type`: The Instance Type for the Launch Configuration. Default is t2.medium
* `associate_public_ip_address`: Associate a public IP address with the instances. Default is false.
* `root_block_device`: A map of for the root block device. Default is a 20GB gp2 device which will be deleted on termination.
* `ebs_block_device`: A list of maps for EBS block devices. Default is one 80GB gp2 device with a device name /dev/sdb which will be deleted on termination.

## Outputs

* `launch_configuration_id`: The Id of the Launch Configuration
* `launch_configuration_name`: The Name of the Launch Configuration

## Terraform Resources

* [aws_launch_configuration](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)
