# IAM Role with Policy

## Usage

```hcl
module "<role name>" {
  name   = "name-for-the-role"
  source = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//iam_role_with_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}
```

## Required Variables

* `name`: The name for the role and policy.
* `policy`: The policy for the role.

## Optional Variables

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
* `policy_id`: The Id of the IAM policy
* `policy_arn`: The Arn of the IAM policy
* `policy_name`: The Name of the IAM policy

## Allstate Resources

[iam_policy](https://github.allstate.com/cloud-engineering/tf-aws-modules/tree/master/iam_policy)
[iam_role](https://github.allstate.com/cloud-engineering/tf-aws-modules/tree/master/iam_role)
[iam_role_policy_attachment](https://github.allstate.com/cloud-engineering/tf-aws-modules/tree/master/iam_role_policy_attachment)
