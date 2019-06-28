# SNS Topic

## Usage

```hcl
module "sns_topic" {
  name   = "sns-topic"
  source = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//sns_topic"
}
```

## Required Variables

* `name`: The name for the SNS topic

## Terraform Resources

* [aws_sns_topic](https://www.terraform.io/docs/providers/aws/r/sns_topic.html)
