# SQS Queue

## Usage

```hcl
module "sqs_queue" {
  queue_name        = "<queue name>"
  kms_master_key_id = "<kms master key id>"
  source            = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//sqs_queue"
}
```

## Required Variables

* `queue_name`: The human readable name of the queue.
* `kms_master_key_id`: The KMS Key Id for encryption and decryption of messages.

## Optional Variables

* `visibility_timeout_seconds`: The visibility timeout for the queue in seconds. Default is 30.
* `message_retention_seconds`: The message retention for the queue in seconds. Default is 60.
* `max_message_size`: The maximum size of the message for the queue in bytes. Default is 262144 bytes.
* `delay_seconds`: The delay for all messages in the queue in seconds. Default is 0
* `receive_wait_time_seconds`: The wait time for a receive message call in seconds. Default is 0
* `fifo_queue`: First In, First Out queue. The default is false
* `kms_data_key_reuse_period_seconds`: Length of time in seconds SQS can reuse a data key to encrypt or decrypt messages. Default is 300.
* `tags`: A map of tags to associate with the queue.

## Outputs

* `queue_id`: The Id of the SQS Queue
* `queue_arn`: The ARN of the SQS Queue

## Terraform Resources

* [aws_sqs_queue](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html)
