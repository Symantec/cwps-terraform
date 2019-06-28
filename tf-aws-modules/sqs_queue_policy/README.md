# SQS Queue Policy

## Usage

```hcl
module "sqs_queue_policy" {
  queue_url = "${module.queue.url}"
  source    = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//sqs_queue_policy"

  policy = <<POLICY
{
  SQS Policy
}
POLICY
}
```

## Required Variables

* `queue_url`: The SQS Queue URL
* `policy`: The SQS Queue Policy

## Terraform Resources

* [aws_sqs_queue_policy](https://www.terraform.io/docs/providers/aws/r/sqs_queue_policy.html)
