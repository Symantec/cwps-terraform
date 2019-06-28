# AutoScaling Group Lifecycle Hook

## Usage

```hcl
module "asg_lifecycle_hook" {
  name =
  autoscaling_group_name  =
  lifecycle_transition    =
  notification_target_arn =
  role_arn                =
  source                  = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//autoscaling_group_lifecycle_hook"
}
```

## Required Variables

* `name`: The name for the Lifecycle Hook
* `autoscaling_group_name`: The name of the AutoScaling Group
* `lifecycle_transition`: The instance state to which you want to attach the lifecycle hook.
* `notification_target_arn`: The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic.
* `role_arn`: The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target.

## Optional Variables

* `default_result`: Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON. The default value for this parameter is ABANDON.
* `heartbeat_timeout`: Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter
* `notification_metadata`: Contains additional information that you want to include any time Auto Scaling sends a message to the notification target.

## Terraform Resources

* [aws_autoscaling_lifecycle_hook](https://www.terraform.io/docs/providers/aws/r/autoscaling_lifecycle_hooks.html)
