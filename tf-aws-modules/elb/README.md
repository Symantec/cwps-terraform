# IAM Role

## Usage

```hcl
module "<role name>" {
  role_name = "IAMRole"
  source    = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//iam_role"
}
```

## Required Variables

* `role_name`: The name of the IAM Role

## Optional Variables

* `role_description`: The description of the IAM Role. Default is an empty string.
* `role_path`: The path to the role. Default is /
* `assume_role_policy`: The AWS service for the IAM Role. Default is:

```
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
```

## Outputs

* `role_arn`: The ARN for the IAM Role.
* `role_unique_id`: The Unique ID for the IAM Role
* `role_name`: The Name of the IAM Role

## Terraform Resources

[aws_iam_role](https://www.terraform.io/docs/providers/aws/r/iam_role.html)
