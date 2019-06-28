# IAM Role Policy Attachment

## Usage

```hcl
module "<role attachment>" {
  role       = "role-name"
  policy_arn = "arn::for::policy::to::attach"
  source     = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//iam_role_policy_attachment"
}
```

## Required Variables

* `role`: The role to have the policy attached.
* `policy_arn`: ARN for the IAM Policy to attach to the role.

## Terraform Resources

[aws_iam_policy_attachment](https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html)
