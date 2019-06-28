# IAM Policy

## Usage

```hcl
module "<policy name>" {
    policy_name = "IAMPolicyName"
    source      = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//iam_policy"

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

* `policy_name`: The name of the IAM Policy
* `policy`: The IAM Policy

## Optional Variables

* `policy_path`: The policy path. Default is /
* `policy_description`: The description of the policy. Default is empty string

## Outputs

* `policy_id`: The Id of the IAM policy
* `policy_arn`: The Arn of the IAM policy
* `policy_name`: The Name of the IAM policy

## Terraform Resources

* [aws_iam_policy](https://www.terraform.io/docs/providers/aws/r/iam_policy.html)
