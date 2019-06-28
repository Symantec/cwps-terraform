# Security Group

## Usage

```hcl
module "<security group name>" {
  name        = "sg_group_name"
  description = "This is a security group"
  vpc_id      = "vpc-1234asdf"
  source      = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//security_group"
}
```

## Required Variables

* `name`: The name of the security group
* `description`: The description for the security group
* `vpc_id`: The VPC Id to associate with the security group

## Optional Variables

* `tags`: A map of tags to associate with the security group

## Outputs

* `security_group_id`: The Id for the security group
* `security_group_name`: The name of the security group

## Terraform Resources

* [aws_security_group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
