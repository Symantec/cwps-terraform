# IAM Instance Profile

## Usage

```hcl
module "<instance profile name>" {
  instance_profile_name = "ec2-instance-profile"
  iam_role              = "ec2-role"
  source                = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//iam_instance_profile"
}
```

## Required Variables

* `instance_profile_name`: The Instance Profile name
* `iam_role`: The IAM Role to associate with the Instance Profile

## Optional Variables

* `instance_profile_path`: The Instance Profile path

## Outputs

* `instance_profile_id`: The Id for the Instance Profile
* `instance_profile_arn`: The Arn for the Instance Profile
* `instance_profile_name`: The Name of the Instance Profile
* `instance_profile_unique_id`: The Unique Id of the Instance Profile
* `instance_profile_path`: The Path of the Instance Profile

## Terraform Resources

* [aws_iam_instance_profile](https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html)
